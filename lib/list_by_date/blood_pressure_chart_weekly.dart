import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BloodPressureChartWeekly extends StatelessWidget {
  final Map<String, dynamic> data = {
    "Week 1": {
      "avg_systolic": 130,
      "avg_diastolic": 85,
      "category": "High"
    },
    "Week 2": {
      "avg_systolic": 120,
      "avg_diastolic": 80,
      "category": "Normal"
    },
    "Week 3": {
      "avg_systolic": 110,
      "avg_diastolic": 75,
      "category": "Normal"
    },
    "Week 4": {
      "avg_systolic": 90,
      "avg_diastolic": 60,
      "category": "Low"
    }
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white30,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 180,
          minY: 0,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                String week = data.keys.toList()[group.x.toInt()];
                var systolic = data[week]['avg_systolic'];
                var diastolic = data[week]['avg_diastolic'];
                var category = data[week]['category'];

                return BarTooltipItem(
                  'Week: $week\nSystolic: $systolic\nDiastolic: $diastolic\nCategory: $category',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    decoration: TextDecoration.none
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 42,
                interval: 20,
                getTitlesWidget: leftTitles,
              ),
            ) ,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 42,
                getTitlesWidget: bottomTitles,
              ),
            ) ,
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: _generateBarGroups(),
          gridData: const FlGridData(show: false),
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
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
      decoration: TextDecoration.none,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Week 1', style: style);
        break;  // Add break to prevent fall-through
      case 1:
        text = const Text('Week 2', style: style);
        break;  // Add break to prevent fall-through
      case 2:
        text = const Text('Week 3', style: style);
        break;  // Add break to prevent fall-through
      case 3:
        text = const Text('Week 4', style: style);
        break;  // Add break to prevent fall-through
      default:
        text = const Text(' ', style: style);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, // margin top
      child: text,
    );
  }


  List<BarChartGroupData> _generateBarGroups() {
    List<BarChartGroupData> barGroups = [];
    List<String> weeks = data.keys.toList();

    for (int i = 0; i < weeks.length; i++) {
      String category = data[weeks[i]]['category'];
      double systolic = (data[weeks[i]]['avg_systolic'] ?? 0).toDouble();
      double diastolic = (data[weeks[i]]['avg_diastolic'] ?? 0).toDouble();

      Color systolicColor;
      Color diastolicColor;

      // Set the color based on category
      if (category == 'High' || category == 'Low') {
        systolicColor = Colors.red;
        diastolicColor = Colors.red;
      } else {
        systolicColor = const Color(0xff53fdd7); // Systolic Normal
        diastolicColor = const Color(0xffc0fffa);// Diastolic Normal
      }

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: systolic,
              color: systolicColor,
              width: 10,
            ),
            BarChartRodData(
              toY: diastolic,
              color: diastolicColor,
              width: 10,
            ),
          ],
        ),
      );
    }
    return barGroups;
  }
}
