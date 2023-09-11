import 'package:amazon/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the user data using the UserProvider
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      height: 40.h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 114, 226, 221),
            Color.fromARGB(255, 126, 236, 233)
          ],
          stops: [0.5, 1.0],
        ),
      ),
      padding: EdgeInsets.only(left: 10.w),
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 20.r,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 5.w),
              // Display user's name and address for delivery
              child: Text(
                'Delivery to ${user.name} - ${user.address}',
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              // Implement action to show more address options
            },
            icon: Icon(
              Icons.arrow_drop_down_outlined,
              size: 20.r,
            ),
          ),
        ],
      ),
    );
  }
}
