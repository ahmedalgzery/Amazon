import 'package:amazon/features/admin/models/sales.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> data;

  const CategoryProductsChart({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      // Define the X-axis as a categorical axis.
      primaryXAxis: CategoryAxis(),

      // Define the series to be displayed in the chart.
      series: <ColumnSeries<Sales, String>>[
        ColumnSeries<Sales, String>(
          // Bind the sales data to the series.
          dataSource: data,

          // Define the X and Y value mapping functions.
          xValueMapper: (Sales sales, _) => sales.label,
          yValueMapper: (Sales sales, _) => sales.earning,
        ),
      ],
    );
  }
}
