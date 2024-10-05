import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class BloodPressureChartAlternative extends StatelessWidget {
  final List<BloodPressureData> data;

  BloodPressureChartAlternative({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Pressure Chart'),
      ),
      body: SfCartesianChart(
        title: ChartTitle(text: 'Blood Pressure Readings'),
        legend: Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.yMd(),
          axisLine: AxisLine(width: 0.5),
          majorGridLines: MajorGridLines(width: 0),
          majorTickLines: MajorTickLines(width: 0),
          title: AxisTitle(text: 'Date'),
        ),
        primaryYAxis: const NumericAxis(
          isVisible: false,
          title: AxisTitle(text: 'Blood Pressure (mmHg)'),
          minimum: -200,  // Minimum Y value for negative diastolic values
          maximum: 200,   // Maximum Y value for positive systolic values
          interval: 50,   // Set intervals on the Y-axis
          axisLine: AxisLine(width: 2),
        ),
        series: <CartesianSeries>[
          // Systolic series (above the zero line)
          ColumnSeries<BloodPressureData, DateTime>(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
            ),
            name: 'Systolic',
            dataSource: data,
            xValueMapper: (BloodPressureData bp, _) => bp.createdAt,
            yValueMapper: (BloodPressureData bp, _) => bp.systolic,
            width: .5,
            color: Colors.blue, // Color for systolic values
            dataLabelSettings: DataLabelSettings(
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.outer // Labels on top of bars
            ),
          ),
          // Diastolic series (below the zero line)
          ColumnSeries<BloodPressureData, DateTime>(
            name: 'Diastolic',
            dataSource: data,
            xValueMapper: (BloodPressureData bp, _) => bp.createdAt,
            yValueMapper: (BloodPressureData bp, _) => -bp.diastolic, // Convert diastolic to negative
            color: Colors.green, // Color for diastolic values
            dataLabelSettings: DataLabelSettings(
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.outer // Labels on top of bars
            ),
          ),
        ],
      ),
    );
  }
}

class BloodPressureData {
  final DateTime createdAt;
  final int systolic;
  final int diastolic;

  BloodPressureData({
    required this.createdAt,
    required this.systolic,
    required this.diastolic,
  });

  factory BloodPressureData.fromJson(Map<String, dynamic> json) {
    return BloodPressureData(
      createdAt: DateTime.parse(json['created_at']),
      systolic: json['systolic'],
      diastolic: json['diastolic'],
    );
  }
}

// Sample test data
final List<BloodPressureData> testDataAlt = [
  BloodPressureData(
    createdAt: DateTime.parse("2024-09-30T13:22:32.000000Z"),
    systolic: 125,
    diastolic: 80,
  ),
  BloodPressureData(
    createdAt: DateTime.parse("2024-09-30T06:01:51.000000Z"),
    systolic: 135,
    diastolic: 90,
  ),
  BloodPressureData(
    createdAt: DateTime.parse("2024-09-29T05:22:09.000000Z"),
    systolic: 120,
    diastolic: 80,
  ),
  BloodPressureData(
    createdAt: DateTime.parse("2024-09-29T05:21:22.000000Z"),
    systolic: 135,
    diastolic: 85,
  ),
  BloodPressureData(
    createdAt: DateTime.parse("2024-09-25T18:52:12.000000Z"),
    systolic: 125,
    diastolic: 85,
  ),
  BloodPressureData(
    createdAt: DateTime.parse("2024-09-25T04:05:39.000000Z"),
    systolic: 135,
    diastolic: 85,
  ),
];
