import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/account/services/account_services.dart';
import 'package:amazon/features/account/widgets/single_product.dart';
import 'package:amazon/features/order_details/screens/order_details.dart';
import 'package:amazon/models/order.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader() // Display loader while fetching orders
        : Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 15.w,
                      ),
                      child: Text(
                        'Your Orders',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        right: 15.w,
                      ),
                      child: Text(
                        'See all',
                        style: TextStyle(
                          color: GlobalVariables.selectedNavBarColor,
                        ),
                      ),
                    ),
                  ],
                ),
                // Display orders as a horizontal scrollable list
                Expanded(
                  child: Container(
                    //height: double.infinity,
                    padding: EdgeInsets.only(
                      left: 10.w,
                      top: 20.h,
                      right: 0,
                    ),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: orders!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to order details screen with order information
                            Navigator.pushNamed(
                              context,
                              OrderDetailScreen.routeName,
                              arguments: orders![index],
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0.w),
                            child: SingleProduct(
                              image: orders![index].products[0].images[0],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
