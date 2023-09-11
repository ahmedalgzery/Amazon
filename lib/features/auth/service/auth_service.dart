// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon/common/widgets/bottom_bar.dart';
import 'package:amazon/constant.dart';
import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/admin/screens/admin_screen.dart';
import 'package:amazon/models/user_model.dart';
import 'package:amazon/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Method to sign up a user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Create a User instance with provided data
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
        cart: [],
      );

      // Send a POST request to the server for user registration
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // Handle errors and show appropriate messages
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context,
              'Account created! Login with the same credentials!', true);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), false);
    }
  }

  // Method to sign in a user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      // Send a POST request to the server for user authentication
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({"email": email, "password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // Handle successful sign-in and navigate to the main screen
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString("x-auth-token", jsonDecode(res.body)["token"]);
          showSnackBar(context, 'Login Succeeded', true);
          Provider.of<UserProvider>(context, listen: false).user.type == 'user'
              ? Navigator.pushNamedAndRemoveUntil(
                  context, BottomBar.routeName, (route) => false)
              : Navigator.pushNamedAndRemoveUntil(
                  context, AdminScreen.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), false);
    }
  }

  // Method to get user data from the server
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      // Check if the stored token is valid
      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      // Decode the token validation response
      var response = jsonDecode(tokenRes.body);

      // If the token is valid, fetch the user's data
      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        // Set the user's data using the Provider
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString(), false);
    }
  }
}
