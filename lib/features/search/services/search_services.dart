// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon/constant.dart';
import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// Define the SearchServices class
class SearchServices {
  // Function to fetch searched products
  Future<List<Product>> fetchSearchedProduct({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      // Send a GET request to fetch searched products
      http.Response res = await http.get(
        Uri.parse('$uri/api/products/search/$searchQuery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      // Handle HTTP response with error handling
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // Convert JSON response to a list of Product objects
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      // Show error message if an exception occurs
      showSnackBar(context, e.toString(),false);
    }
    // Return the list of fetched products
    return productList;
  }
}
