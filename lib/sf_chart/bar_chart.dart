import 'package:flutter/material.dart';

import 'chart_column.dart';

class BarChart extends StatelessWidget {
  const BarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ChartColumn()
            ],
          ),
        ),
      ),),
    );
  }
}

