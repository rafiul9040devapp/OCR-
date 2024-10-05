// import 'package:flutter/material.dart';
// import 'package:charts_painter/chart.dart';
// import 'package:flutter/material.dart';
//
//
//
// class VerticalBarChartPainter extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bar chart up/down'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: BarChart(
//             data: getChartData(),
//             xAxisStyle: const AxisStyle(
//               labelStyle: TextStyle(color: Colors.black),
//               gridStyle: GridStyle(show: true),
//             ),
//             yAxisStyle: const AxisStyle(
//               labelStyle: TextStyle(color: Colors.black),
//               gridStyle: GridStyle(show: true),
//             ),
//             barStyle: BarStyle(
//               colors: [
//                 Colors.cyan,
//                 Colors.blue,
//               ],
//               width: 20,
//             ),
//             chartStyle: ChartStyle(
//               showLegends: false,
//               showGrid: true,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   List<BarChartData> getChartData() {
//     return [
//       BarChartData(x: 'Jan', y: 6),
//       BarChartData(x: 'Feb', y: -4),
//       BarChartData(x: 'Mar', y: 5),
//       BarChartData(x: 'Apr', y: -3),
//       BarChartData(x: 'May', y: 7),
//       BarChartData(x: 'Jun', y: -5),
//       BarChartData(x: 'Jul', y: 8),
//       BarChartData(x: 'Aug', y: -6),
//       BarChartData(x: 'Sep', y: 9),
//       BarChartData(x: 'Oct', y: -7),
//       BarChartData(x: 'Nov', y: 6),
//       BarChartData(x: 'Dec', y: -3),
//     ];
//   }
// }
//
// class BarChartData {
//   BarChartData({required this.x, required this.y});
//   final String x; // Month
//   final double y; // Sales
// }
