import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CategoryScreenAppBar extends StatelessWidget {
  final String category;
  const CategoryScreenAppBar({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: GlobalVariables.appBarGradient,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Image.asset(
              'assets/images/amazon_in.png', // Display Amazon logo image
              width: 120,
              height: 45,
              color: Colors.black, // Apply black color to the logo
            ),
          ),
          Text(
            category, // Display the provided category name
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black, // Apply black color to the category name
            ),
          ),
        ],
      ),
    );
  }
}
