import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GlucoseBarChartWeeklyAlternative extends StatefulWidget {
  final Map<String, dynamic> responseData;

  const GlucoseBarChartWeeklyAlternative({super.key, required this.responseData});

  @override
  State<StatefulWidget> createState() => GlucoseBarChartWeeklyAlternativeState();
}

class GlucoseBarChartWeeklyAlternativeState extends State<GlucoseBarChartWeeklyAlternative> {
  final double width = 22;
  late List<BarChartGroupData> showingBarGroups;
  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    showingBarGroups = _generateBarGroups();
  }

  List<BarChartGroupData> _generateBarGroups() {
    List<BarChartGroupData> barGroups = [];
    final weeks = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];

    for (int i = 0; i < weeks.length; i++) {
      final weekData = widget.responseData[weeks[i]];

      if (weekData['avg_level'] != null) {
        final avgLevel = weekData['avg_level'] as double;
        final category = weekData['category'] as String;

        // Set the color based on the category
        final barColor = (category == 'High' || category == 'Low') ? Colors.red : Colors.green;

        barGroups.add(makeGroupData(i, avgLevel, barColor));
      } else {
        // Add an empty bar for weeks without data
        barGroups.add(makeGroupData(i, 0, Colors.transparent));
      }
    }
    return barGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BarChart(
          BarChartData(
            maxY: 20,
            barTouchData: BarTouchData(
              enabled: false,
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final weekData = widget.responseData['Week ${group.x + 1}'];
                  if (rod.toY == 0) return null; // No tooltip if the value is 0
                  final category = weekData['category'] as String;
                  return BarTooltipItem(
                    'Week ${group.x + 1}\n',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Avg Level: ${rod.toY}\n',
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      TextSpan(
                        text: 'Category: $category',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  );
                },
              ),
              touchCallback: (FlTouchEvent event, response) {
                if (response == null || response.spot == null) {
                  setState(() {
                    touchedGroupIndex = -1;
                  });
                  return;
                }
                touchedGroupIndex = response.spot!.touchedBarGroupIndex;
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final weeks = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
                    return Text(
                      weeks[value.toInt()],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                  reservedSize: 28,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 2,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: false),
            barGroups: showingBarGroups,
            gridData: const FlGridData(show: false),
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y, Color barColor) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: barColor,
          width: width,
        ),
      ],
      showingTooltipIndicators: y == 0 ? [] : [0],
    );
  }
}
