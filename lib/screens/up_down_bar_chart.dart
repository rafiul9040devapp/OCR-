// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
//
// class UpDownBarChart extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Bar chart up/down')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: BarChart(
//           BarChartData(
//             alignment: BarChartAlignment.spaceAround,
//             maxY: 10,  // Maximum Y value
//             minY: -10, // Minimum Y value
//             barTouchData: BarTouchData(enabled: false),
//             titlesData: FlTitlesData(
//               show: true,
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   getTitlesWidget: (double value, TitleMeta meta) {
//                     final monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
//                     return Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: Text(monthNames[value.toInt()]),
//                     );
//                   },
//                   reservedSize: 32,
//                 ),
//               ),
//               leftTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   interval: 2,
//                 ),
//               ),
//             ),
//             borderData: FlBorderData(show: false),
//             gridData: FlGridData(show: true, drawHorizontalLine: true, horizontalInterval: 2),
//             barGroups: [
//               makeGroupData(0, 6, -3),
//               makeGroupData(1, 5, -4),
//               makeGroupData(2, 7, -2),
//               makeGroupData(3, 6, -5),
//               makeGroupData(4, 8, -3),
//               makeGroupData(5, 9, -2),
//               makeGroupData(6, 6, -4),
//               makeGroupData(7, 5, -3),
//               makeGroupData(8, 7, -5),
//               makeGroupData(9, 8, -4),
//               makeGroupData(10, 5, -2),
//               makeGroupData(11, 6, -3),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   BarChartGroupData makeGroupData(int x, double upValue, double downValue) {
//     return BarChartGroupData(
//       x: x,
//       barRods: [
//         BarChartRodData(
//           toY: upValue,
//           color: Colors.blueAccent, // Upward bar color
//           width: 10,
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
//         ),
//         BarChartRodData(
//           toY: downValue,
//           color: Colors.cyan, // Downward bar color
//           width: 10,
//           borderRadius: const BorderRadius.vertical(bottom: Radius.circular(0)),
//         ),
//       ],
//     );
//   }
// }
