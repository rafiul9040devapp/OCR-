import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BarChartSample2 extends StatefulWidget {
  BarChartSample2({super.key});

  final Color leftBarColor = const Color(0xff53fdd7);// Systolic color
  final Color rightBarColor = const Color(0xffc0fffa); // Diastolic color
  final Color avgColor = Colors.green; // Average color for touched bars

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final double width = 7;

  late List<BarChartGroupData> showingBarGroups;
  int touchedGroupIndex = -1;

  // API Response
  Map<String, dynamic> apiResponse = {
    "2024-09-30": {
      "systolic_avg": 130,
      "diastolic_avg": 85
    },
    "2024-09-29": {
      "systolic_avg": 127.5,
      "diastolic_avg": 82.5
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
        double systolic = (apiResponse[date]['systolic_avg'] as num).toDouble();
        double diastolic = (apiResponse[date]['diastolic_avg'] as num).toDouble();
        barGroups.add(makeGroupData(i, systolic, diastolic));
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
              maxY: 200, // Adjust maxY for Systolic values
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    String day = getLast7Days()[group.x.toInt()];
                    // Get both systolic and diastolic values for the touched group
                    double systolic = group.barRods[0].toY; // First rod represents Systolic
                    double diastolic = group.barRods[1].toY; // Second rod represents Diastolic

                    return BarTooltipItem(
                      'Date: $day\nSystolic: $systolic\nDiastolic: $diastolic',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
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
                    reservedSize: 42,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: 20,
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
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 20:
        text = '20';
        break;
      case 40:
        text = '40';
        break;
      case 60:
        text = '60';
        break;
      case 80:
        text = '80';
        break;
      case 100:
        text = '100';
        break;
      case 120:
        text = '120';
        break;
      case 140:
        text = '140';
        break;
      case 160:
        text = '160';
        break;
      case 180:
        text = '180';
        break;
      case 200:
        text = '200';
        break;
      default:
        return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final last7Days = getLast7Days();
    final Widget text = Text(
      DateFormat('MM/dd/yy').format(DateTime.parse(last7Days[value.toInt()])),
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 10,
        decoration: TextDecoration.none,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, // margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double systolic, double diastolic) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: systolic.toDouble(), // Systolic value
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: diastolic.toDouble(), // Diastolic value
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }
}
