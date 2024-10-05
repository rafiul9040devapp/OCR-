import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class BloodPressureChart extends StatelessWidget {
  final List<BloodPressureData> data;

  BloodPressureChart({required this.data});

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
          dateFormat: DateFormat.yMd().add_Hm(),
          title: AxisTitle(text: 'Time'),
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(text: 'Systolic'),
        ),
        axes: <ChartAxis>[
          NumericAxis(
            name: 'Diastolic',
            title: AxisTitle(text: 'Diastolic'),
            opposedPosition: true,
          )
        ],
        series: <LineSeries<BloodPressureData, DateTime>>[
          LineSeries<BloodPressureData, DateTime>(
            name: 'Systolic',
            dataSource: data,
            xValueMapper: (BloodPressureData bp, _) => bp.createdAt,
            yValueMapper: (BloodPressureData bp, _) => bp.systolic,
            markerSettings: MarkerSettings(isVisible: true),
          ),
          LineSeries<BloodPressureData, DateTime>(
            name: 'Diastolic',
            dataSource: data,
            xValueMapper: (BloodPressureData bp, _) => bp.createdAt,
            yValueMapper: (BloodPressureData bp, _) => bp.diastolic,
            yAxisName: 'Diastolic', // Maps to the secondary Y axis
            markerSettings: MarkerSettings(isVisible: true),
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

// Hardcoded test data
final List<BloodPressureData> testData = [
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
