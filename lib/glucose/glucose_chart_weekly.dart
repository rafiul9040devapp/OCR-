import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _BarChart extends StatelessWidget {
  final Map<String, dynamic> apiData;

  const _BarChart({required this.apiData});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 20, // Max value to display on the chart
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: true,
    touchTooltipData: BarTouchTooltipData(
      getTooltipColor: (group) => Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        // Get the week key using the group index
        String weekKey = 'Week ${groupIndex + 1}';
        var weekData = apiData[weekKey];

        // Check if week data exists and prepare tooltip text
        if (weekData != null) {
          double avgLevel = weekData['avg_level'] ;
          String category = weekData['category'] ;

          if(avgLevel!=0){
            return BarTooltipItem(
              'Sugar Level: ${avgLevel.toString()}\nStatus: $category',
              const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          }
          else {
            return null;
          }
        } else {
          return null;
        }
      },
    ),
  );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
      decoration: TextDecoration.none,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Week 1';
        break;
      case 1:
        text = 'Week 2';
        break;
      case 2:
        text = 'Week 3';
        break;
      case 3:
        text = 'Week 4';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: getTitles,
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
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  Color _getBarColor(String category) {
    if (category == "High" || category == "Low") {
      return Colors.redAccent;
    } else {
      return Colors.blueGrey; // Use any color other than red for NA or other categories
    }
  }

  List<BarChartGroupData> get barGroups {
    final List<BarChartGroupData> groups = [];

    apiData.forEach((key, value) {
      int index = int.parse(key.split(' ')[1]) - 1; // Extract week number and subtract 1 to get index
      double avgLevel = value['avg_level'] ?? 0; // Handle null avg_level by defaulting to 0
      String category = value['category'] ?? 'NA'; // Handle null category

      // Add BarChartGroupData
      groups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: avgLevel, // Use avg_level as bar height
              color: _getBarColor(category), // Color based on category
            )
          ],
          showingTooltipIndicators: [0],
        ),
      );
    });

    return groups;
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
}

class BarChartSample3 extends StatefulWidget {
  final Map<String, dynamic> apiData;

  const BarChartSample3({super.key, required this.apiData});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: _BarChart(apiData: widget.apiData),
    );
  }
}
