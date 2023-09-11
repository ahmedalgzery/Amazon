import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/admin/models/sales.dart';
import 'package:amazon/features/admin/services/admin_services.dart';
import 'package:amazon/features/admin/widgets/category_products_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  double? totalSales; // Holds the total earnings
  List<Sales>? earnings; // Holds the sales data

  @override
  void initState() {
    super.initState();
    getEarnings(); // Fetch earnings data when the screen is initialized
  }

  // Function to fetch earnings data
  Future<void> getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    setState(() {
      totalSales = earningData['totalEarnings']; // Update total earnings
      earnings = earningData['sales']; // Update sales data
    });
  }

  @override
  Widget build(BuildContext context) {
    // Display loader if earnings or totalSales is null
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                '\$${totalSales!.ceil()}', // Display total earnings
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 250.h,
                child: CategoryProductsChart(
                  data: earnings!, // Pass sales data to the chart widget
                ),
              ),
            ],
          );
  }
}
