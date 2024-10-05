import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VerticalBarChartPainter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bar chart up/down'),
      ),
      body: SfCartesianChart(
        title: ChartTitle(text: 'Bar chart up/down'),
        primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
          labelPlacement: LabelPlacement.onTicks,
        ),
        primaryYAxis: NumericAxis(
          minimum: -10,
          maximum: 10,
          interval: 2,
          majorGridLines: MajorGridLines(width: 1),
        ),
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: getChartData(),
            xValueMapper: (ChartData data, _) => data.month,
            yValueMapper: (ChartData data, _) => data.sales,
            pointColorMapper: (ChartData data, _) =>
            data.sales >= 0 ? Colors.blue : Colors.cyan,
            width: 0.7,
            gradient: LinearGradient(
              colors: [Colors.cyan, Colors.blue],
              stops: [0.5, 1.0],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ],
      ),
    );
  }

  List<ChartData> getChartData() {
    return <ChartData>[
      ChartData('Jan', 6),
      ChartData('Feb', -4),
      ChartData('Mar', 5),
      ChartData('Apr', -3),
      ChartData('May', 7),
      ChartData('Jun', -5),
      ChartData('Jul', 8),
      ChartData('Aug', -6),
      ChartData('Sep', 9),
      ChartData('Oct', -7),
      ChartData('Nov', 6),
      ChartData('Dec', -3),
    ];
  }
}

class ChartData {
  ChartData(this.month, this.sales);
  final String month;
  final double sales;
}
