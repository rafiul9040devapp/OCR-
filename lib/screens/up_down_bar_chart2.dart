import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class UpDownBarChart2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Blood Pressure Chart'),
        ),
        body: Center(
          child: BloodPressureBarChart(),
        ),
      ),
    );
  }
}

class BloodPressureBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 180,
          barTouchData: BarTouchData(
            enabled: true,
            allowTouchBarBackDraw: true
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const style = TextStyle(
                    color: Color(0xff7589a2),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  );
                  Widget text;
                  switch (value.toInt()) {
                    case 8:
                      text = Text('8 AM', style: style);
                      break;
                    case 10:
                      text = Text('10 AM', style: style);
                      break;
                    case 12:
                      text = Text('12 PM', style: style);
                      break;
                    case 14:
                      text = Text('2 PM', style: style);
                      break;
                    case 16:
                      text = Text('4 PM', style: style);
                      break;
                    case 18:
                      text = Text('6 PM', style: style);
                      break;
                    case 20:
                      text = Text('8 PM', style: style);
                      break;
                    default:
                      text = Text('');
                      break;
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: text,
                  );
                },
                reservedSize: 32,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const style = TextStyle(
                    color: Color(0xff7589a2),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  );
                  String text;
                  if (value == 0) {
                    text = '0';
                  } else if (value == 40) {
                    text = '40';
                  } else if (value == 80) {
                    text = '80';
                  } else if (value == 120) {
                    text = '120';
                  } else if (value == 160) {
                    text = '160';
                  } else {
                    text = '';
                  }
                  return Text(text, style: style);
                },
                reservedSize: 32,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: [
            makeGroupData(8, 120, 80),
            makeGroupData(10, 100, 60),
            makeGroupData(12, 110, 70),
            makeGroupData(14, 130, 90),
            makeGroupData(16, 105, 65),
            makeGroupData(18, 115, 75),
            makeGroupData(20, 120, 80),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double systolic, double diastolic) {
    return BarChartGroupData(barsSpace: 8, x: x, barRods: [
      BarChartRodData(
        fromY: 0,
        toY: systolic,
        color: const Color(0xff53fdd7),
        width: 16,
      ),
      BarChartRodData(
        fromY: 0,
        toY: diastolic,
        color: const Color(0xffc0fffa),
        width: 16,
      ),
    ]);
  }
}
