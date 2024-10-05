import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartColumn extends StatelessWidget {
  const ChartColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vertical Bar',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Statistics of the month',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert,size: 40)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 27,
                  height: 13,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Data One',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 27,
                  height: 13,
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Data Two',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 16),

            SfCartesianChart(
              plotAreaBackgroundColor: Colors.transparent,
              margin: EdgeInsets.all(0),
              borderColor: Colors.transparent,
              borderWidth: 0,
              plotAreaBorderWidth: 0,
              enableSideBySideSeriesPlacement: false,
              primaryXAxis: CategoryAxis(

              ),
            )
          ],
        ),
      ),
    );
  }
}
