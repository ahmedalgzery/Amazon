import 'package:amazon/features/home/widgets/address_box.dart';
import 'package:amazon/features/home/widgets/carousel_image.dart';
import 'package:amazon/features/home/widgets/deal_of_day.dart';
import 'package:amazon/features/home/widgets/home_screen_app_bar.dart';
import 'package:amazon/features/home/widgets/top_categoeries.dart';
import 'package:amazon/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "/home";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Function to navigate to the search screen
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use the custom app bar with search functionality
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: HomeScreenAppBar(
          onFieldSubmitted: navigateToSearchScreen,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Display the user's address
            const AddressBox(),
            SizedBox(
              height: 10.h,
            ),
            // Show top categories for navigation
            const TopCategories(),
            SizedBox(
              height: 10.h,
            ),
            // Display carousel images for featured products
            const CarouselImage(),
            // Display the deal of the day section
            const DealOfDay(),
          ],
        ),
      ),
    );
  }
}
