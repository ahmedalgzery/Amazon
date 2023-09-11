// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:amazon/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/models/user_model.dart';
import 'package:amazon/provider/user_provider.dart';

class AddressServices {
  // Save user address to the server
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'address': address,
        }),
      );

      // Handle HTTP response using error handling function
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // Update the user's address in the local provider state
          User user = userProvider.user.copyWith(
            address: jsonDecode(res.body)['address'],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(),false);
    }
  }

  // Place an order with the user's cart and address
  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(Uri.parse('$uri/api/order'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalSum,
          }));

      // Handle HTTP response using error handling function
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // Clear the user's cart after placing an order
          User user = userProvider.user.copyWith(
            cart: [],
          );
          userProvider.setUserFromModel(user);

          // Display a success message
          showSnackBar(context, 'Your order has been placed!',true);
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(),false);
    }
  }

  // Delete a product from the server
  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      // Handle HTTP response using error handling function
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // Call the success callback after product deletion
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(),false);
    }
  }
}
