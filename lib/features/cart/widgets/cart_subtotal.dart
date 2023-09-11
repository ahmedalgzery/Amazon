import 'package:amazon/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the user's cart information using the UserProvider
    final user = context.watch<UserProvider>().user;

    // Calculate the subtotal of items in the cart
    double sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] )
        .toList();

    // Display the subtotal information
    return Container(
      margin: EdgeInsets.all(10.w),
      child: Row(
        children: [
          // Display the "Subtotal" label
          Text(
            'Subtotal ',
            style: TextStyle(
              fontSize: 20.sp,
            ),
          ),
          // Display the calculated subtotal amount
          Text(
            '\$$sum',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
