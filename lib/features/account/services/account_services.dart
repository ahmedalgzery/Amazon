// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:amazon/constant.dart';
import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/auth/screens/auth_screen.dart';
import 'package:amazon/models/order.dart';
import 'package:amazon/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Define the AccountServices class
class AccountServices {
  // Method to fetch user's orders
  Future<List<Order>> fetchMyOrders({
    required BuildContext context,
  }) async {
    // Get the userProvider using Provider.of
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Initialize an empty list to store orders
    List<Order> orderList = [];

    try {
      // Make an HTTP GET request to fetch user's orders
      http.Response res = await http.get(Uri.parse('$uri/api/orders/me'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      // Handle the response using httpErrorHandle function
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // Loop through the response data and add each order to the orderList
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      // Handle exceptions by showing a snackbar
      showSnackBar(context, e.toString(),false);
    }
    
    // Return the list of orders
    return orderList;
  }

  // Method to log out the user
  void logOut(BuildContext context) async {
    try {
      // Get an instance of SharedPreferences
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      
      // Clear the user's token stored in SharedPreferences
      await sharedPreferences.setString('x-auth-token', '');
      
      // Navigate to the AuthScreen and remove all previous routes from the stack
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      // Handle exceptions by showing a snackbar
      showSnackBar(context, e.toString(),false);
    }
  }
}
