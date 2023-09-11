import 'package:amazon/common/widgets/stars.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate the average rating for the product
    double totalRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    double avgRating = 0;
    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }

    // Build the UI for displaying the searched product
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(
            horizontal: 10.w,
          ),
          child: Row(
            children: [
              // Display product image
              Image.network(
                product.images[0],
                fit: BoxFit.fill,
                height: 130.h,
                width: 115.w,
              ),
              Expanded(
                child: Column(
                  children: [
                    // Display product name
                    Container(
                      width: 235.w,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    // Display product rating stars
                    Container(
                      width: 235.w,
                      padding: EdgeInsets.only(left: 10.w, top: 5.h),
                      child: Stars(
                        rating: avgRating,
                      ),
                    ),
                    // Display product price
                    Container(
                      width: 235.w,
                      padding: EdgeInsets.only(left: 10.w, top: 5.h),
                      child: Text(
                        '\$${product.price}',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    // Display eligibility for free shipping
                    Container(
                      width: 235.w,
                      padding: EdgeInsets.only(left: 10.w),
                      child: const Text('Eligible for FREE Shipping'),
                    ),
                    // Display product stock status
                    Container(
                      width: 235,
                      padding: EdgeInsets.only(left: 10.w, top: 5.h),
                      child: const Text(
                        'In Stock',
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
