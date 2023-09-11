import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:amazon/constants/global_variables.dart';

class Stars extends StatelessWidget {
  final double rating;

  const Stars({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      direction: Axis.horizontal, // Display stars horizontally
      itemCount: 5, // Total number of stars
      rating: rating, // Current rating value
      itemSize: 15, // Size of each star
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: GlobalVariables.secondaryColor, // Star color
      ),
    );
  }
}
