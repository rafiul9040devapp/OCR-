import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class BarChartSample1 extends StatefulWidget {
  BarChartSample1({super.key});

  final Color barBackgroundColor = Colors.white30;
  final Color barColor = Colors.white;
  final Color touchedBarColor = Colors.greenAccent;

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  // Response data
  // final Map<String, Map<String, dynamic>> responseData = {
  //   "Week 1": {"avg_level": 7.2, "category": "High"},
  //   "Week 2": {"avg_level": null, "category": "NA"},
  //   "Week 3": {"avg_level": null, "category": "NA"},
  //   "Week 4": {"avg_level": null, "category": "NA"},
  // };

  Map<String, dynamic> responseData = {
    "Week 1": {"avg_level": 7.2, "category": "High"},
    "Week 2": {"avg_level": 5.0, "category": "Low"},
    "Week 3": {"avg_level": 0.0, "category": "NA"},
    "Week 4": {"avg_level": 6.0, "category": "Normal"},
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: BarChart(
                        mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
      int x,
      double y, {
        bool isTouched = false,
        Color? barColor,
        double width = 22,
        List<int> showTooltips = const [],
      }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? barColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: barColor)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() {
    return List.generate(4, (i) {
      final week = responseData["Week ${i + 1}"];
      final avgLevel = week!['avg_level'] ?? 0.0; // fallback to 0 if null
      final category = week['category'];

      // Determine bar color based on category
      final barColor = (category == "High" || category == "Low")
          ? Colors.redAccent
          : Colors.greenAccent;

      return makeGroupData(i, avgLevel, isTouched: i == touchedIndex, barColor: barColor);
    });
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.center,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            final week = responseData["Week ${groupIndex + 1}"];
            final avgLevel = week!['avg_level'] ?? 0.0;
            final category = week['category'];

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
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
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
            getTitlesWidget: getTitles,
            reservedSize: 38,
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
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    switch (value.toInt()) {
      case 0:
        return const Text('WEEK1', style: style);
      case 1:
        return const Text('WEEK2', style: style);
      case 2:
        return const Text('WEEK3', style: style);
      case 3:
        return const Text('WEEK4', style: style);
      default:
        return const Text('', style: style);
    }
  }
}
