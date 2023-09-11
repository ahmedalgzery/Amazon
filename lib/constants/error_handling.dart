import 'dart:convert';
import 'package:amazon/constants/utils.dart'; 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  // Function to handle HTTP response errors
  switch (response.statusCode) {
    case 200:
      onSuccess(); // Execute the success callback
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg'],false); // Display error message from response body
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error'],false); // Display error message from response body
      break;
    default:
      showSnackBar(context, response.body,false); // Display the response body as an error message
  }
}
