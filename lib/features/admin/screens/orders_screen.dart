import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/account/widgets/single_product.dart';
import 'package:amazon/features/admin/services/admin_services.dart';
import 'package:amazon/features/order_details/screens/order_details.dart';
import 'package:amazon/models/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders; // Holds the list of orders
  final AdminServices adminServices = AdminServices(); // AdminServices instance

  @override
  void initState() {
    super.initState();
    fetchOrders(); // Fetch orders when the screen is initialized
  }

  // Function to fetch orders
  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context); // Fetch orders data
    setState(() {}); // Update the UI with fetched data
  }

  @override
  Widget build(BuildContext context) {
    // Display loader if orders is null
    return orders == null
        ? const Loader()
        : Padding(
            padding: EdgeInsets.all(8.0.w),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: orders!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.w,
                  mainAxisSpacing: 10.h),
              itemBuilder: (context, index) {
                final orderData = orders![index]; // Current order data
                return GestureDetector(
                  onTap: () {
                    // Navigate to OrderDetailScreen with orderData as arguments
                    Navigator.pushNamed(
                      context,
                      OrderDetailScreen.routeName,
                      arguments: orderData,
                    );
                  },
                  child: SizedBox(
                    height: 140.h,
                    child: SingleProduct(
                      image: orderData
                          .products[0].images[0], // Display product image
                    ),
                  ),
                );
              },
            ),
          );
  }
}
