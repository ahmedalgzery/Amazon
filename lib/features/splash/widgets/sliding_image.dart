import 'package:flutter/material.dart';

class SlidingImage extends StatelessWidget {
  const SlidingImage({
    Key? key,
    required this.slidingAnimation,
  }) : super(key: key);

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, _) {
        // Wrap the image widget with SlideTransition to apply sliding animation.
        return SlideTransition(
          position:
              slidingAnimation, // Use slidingAnimation for the animation effect.
          child: Image.asset('assets/images/amazon_logo.png')
        );
      },
    );
  }
}
