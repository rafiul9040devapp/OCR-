import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GlucoseChartDaily extends StatefulWidget {
  const GlucoseChartDaily({super.key});

  final Color barColor = const Color(0xffc0fffa);

  @override
  State<GlucoseChartDaily> createState() => _GlucoseChartDailyState();
}

class _GlucoseChartDailyState extends State<GlucoseChartDaily> {
  final double width = 7;

  late List<BarChartGroupData> showingBarGroups;
  int touchedGroupIndex = -1;

  Map<String, dynamic> apiResponse = {
    "2024-10-03": {
      "value_one": 5,
      "value_two": 7
    },
    "2024-09-30": {
      "value_one": 5,
      "value_two": 7
    },
    "2024-09-29": {
      "value_one": 8,
      "value_two": 6.7
    }
  };

  // Fetch the last 7 days
  List<String> getLast7Days() {
    List<String> last7Days = [];
    DateTime now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      DateTime date = now.subtract(Duration(days: i));
      last7Days.add(DateFormat('yyyy-MM-dd').format(date));
    }
    return last7Days;
  }

  @override
  void initState() {
    super.initState();
    showingBarGroups = _buildBarGroups();
  }

  List<BarChartGroupData> _buildBarGroups() {
    final last7Days = getLast7Days();
    List<BarChartGroupData> barGroups = [];

    for (int i = 0; i < last7Days.length; i++) {
      String date = last7Days[i];
      if (apiResponse.containsKey(date)) {
        double valueOne = (apiResponse[date]['value_one'] as num).toDouble();
        double valueTwo = (apiResponse[date]['value_two'] as num).toDouble();
        barGroups.add(makeGroupData(i, valueOne, valueTwo));
      } else {
        barGroups.add(makeGroupData(i, 0, 0)); // Show no bar if data is missing
      }
    }
    return barGroups.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          color: Colors.white30,
          child: BarChart(
            BarChartData(
              maxY: 15, // Set max Y value
              minY: 0, // Adjust min Y for values
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: ((group) {
                    return Colors.black12;
                  }),
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    String day = getLast7Days()[group.x.toInt()];
                    String valueToShow;

                    if (rodIndex == 0) {
                      valueToShow = 'Input1: ${rod.toY.toString()}'; // For bar 1
                    } else {
                      valueToShow = 'Input2: ${rod.toY.toString()}'; // For bar 2
                    }

                    return BarTooltipItem(
                      'Date: $day\n$valueToShow',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        decoration: TextDecoration.none,
                      ),
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
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: bottomTitles,
                    reservedSize: 40,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: 5, // Set interval to 5
                    getTitlesWidget: leftTitles,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: showingBarGroups,
              gridData: const FlGridData(show: false),
            ),
          ),
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
      decoration: TextDecoration.none,
    );
    String text = value.toInt().toString();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final last7Days = getLast7Days();
    final Widget text = Text(
      DateFormat('dMMMyy').format(DateTime.parse(last7Days[value.toInt()])),
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
        decoration: TextDecoration.none,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double valueOne, double valueTwo) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: valueOne.toDouble(), // First bar
          color: widget.barColor,
          width: width,
        ),
        BarChartRodData(
          toY: valueTwo.toDouble(), // Second bar
          color: widget.barColor,
          width: width,
        ),
      ],
    );
  }
}
