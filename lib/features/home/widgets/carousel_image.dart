import 'package:amazon/constants/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      // Create a list of image widgets using the carouselImages from GlobalVariables
      items: GlobalVariables.carouselImages
          .map(
            (i) => Builder(
              builder: (context) => Image.network(
                i,
                fit: BoxFit.fill,
                height: 200.h,
              ),
            ),
          )
          .toList(),
      // Configure carousel options
      options: CarouselOptions(
        viewportFraction: 1, // Display one full image at a time
        height: 200.h, // Set the height of the carousel
      ),
    );
  }
}
