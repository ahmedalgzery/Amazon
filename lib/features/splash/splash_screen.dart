import 'package:amazon/common/widgets/bottom_bar.dart';
import 'package:amazon/features/admin/screens/admin_screen.dart';
import 'package:amazon/features/auth/screens/auth_screen.dart';
import 'package:amazon/features/splash/widgets/sliding_image.dart';
import 'package:amazon/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });
  static const String routeName = '/splash-screen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigateTo();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // SlidingText widget to show sliding animation of the Image.
      body: Center(child: SlidingImage(slidingAnimation: slidingAnimation)),
    );
  }

  // Initialize the sliding animation.
  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    slidingAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(animationController);
    animationController.forward();
  }

  // Navigate to the route after a delay.
  void navigateTo() {
    Future.delayed(const Duration(seconds: 4), () {
      Provider.of<UserProvider>(context, listen: false).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context, listen: false).user.type ==
                  'user'
              ? Navigator.pushNamed(context,
                  BottomBar.routeName) // Show bottom navigation for user
              : Navigator.pushNamed(
                  context, AdminScreen.routeName) // Show admin screen for admin
          : Navigator.pushNamed(
              context,
              AuthScreen
                  .routeName); // Show authentication screen for non-authenticated users
    });
  }
}
