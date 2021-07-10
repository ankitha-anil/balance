import 'dart:math';

import 'package:balance/Measurements.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:balance/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class MeasurementResultScreen extends StatefulWidget {
  static String id = 'WeightScreenPage';
  @override
  _MeasurementResultScreenState createState() =>
      _MeasurementResultScreenState();
}

class _MeasurementResultScreenState extends State<MeasurementResultScreen> {
  final _firestore = FirebaseFirestore.instance;

  List<Measurement> measuredata = [];

  var bmi;
  int height = 155;

  String getResult(var bmi) {
    if (bmi >= 25)
      return 'Overweight';
    else if (bmi > 18.5)
      return 'Normal';
    else
      return 'Underweight';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: klightBlue,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Result', style: kheadingStyle),
              StreamBuilder(
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    ));
                  }
                  final texts = snapshot.data.docs.reversed;

                  for (var data in texts) {
                    // print(data);
                    final time = data['time'];
                    final weight = data['weight'];
                    final waist = data['waist'];
                    final hips = data['hips'];
                    final arms = data['arms'];
                    final thighs = data['thighs'];

                    //final measurement =
                    //Text(time.toDate().toString(), style: klabelTextStyle);

                    //measuredata.add(measurement);

                    bmi = weight / pow(height / 100, 2);

                    var measurement = Measurement(
                        time: time.toDate(),
                        weight: weight,
                        waist: waist,
                        hips: hips,
                        arms: arms,
                        thighs: thighs);

                    measuredata.add(measurement);
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              SfCartesianChart(
                                  enableAxisAnimation: true,
                                  // plotAreaBackgroundColor: Colors.grey,
                                  primaryXAxis: DateTimeCategoryAxis(
                                    dateFormat: DateFormat.MMMEd(),
                                    majorGridLines: MajorGridLines(width: 0),
                                    autoScrollingDeltaType:
                                        DateTimeIntervalType.days,
                                    visibleMinimum: DateTime.now()
                                        .subtract(const Duration(days: 5)),
                                    visibleMaximum: DateTime.now(),
                                  ),
                                  zoomPanBehavior: ZoomPanBehavior(
                                    enablePanning: true,
                                  ),
                                  primaryYAxis: NumericAxis(
                                    visibleMinimum: 40,
                                    visibleMaximum: 70,
                                    interval: 5,
                                  ),
                                  tooltipBehavior:
                                      TooltipBehavior(enable: true),
                                  series: <ChartSeries<Measurement, DateTime>>[
                                    LineSeries<Measurement, DateTime>(
                                      dataSource: measuredata,
                                      xValueMapper: (Measurement measure, _) =>
                                          measure.time,
                                      yValueMapper: (Measurement measure, _) =>
                                          measure.weight,
                                      markerSettings:
                                          MarkerSettings(isVisible: true),
                                      name: 'Weight',
                                      color: kyellow,
                                      // Enable data label
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'BMI : ${bmi.toStringAsFixed(2)} , ${getResult(bmi)}',
                        style: ktextStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SfCartesianChart(
                              primaryXAxis: DateTimeCategoryAxis(
                                dateFormat: DateFormat.MMMEd(),
                                majorGridLines: MajorGridLines(width: 0),
                                autoScrollingDeltaType:
                                    DateTimeIntervalType.days,
                                visibleMinimum: DateTime.now()
                                    .subtract(const Duration(days: 5)),
                                visibleMaximum: DateTime.now(),
                              ),
                              zoomPanBehavior: ZoomPanBehavior(
                                enablePanning: true,
                              ),
                              primaryYAxis: NumericAxis(
                                anchorRangeToVisiblePoints: true,
                                visibleMinimum: 5,
                                visibleMaximum: 35,
                              ),
                              legend: Legend(
                                isVisible: true,
                                position: LegendPosition.top,
                              ),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <ChartSeries<Measurement, DateTime>>[
                                LineSeries<Measurement, DateTime>(
                                  dataSource: measuredata,
                                  xValueMapper: (Measurement measure, _) =>
                                      measure.time,
                                  yValueMapper: (Measurement measure, _) =>
                                      measure.waist,
                                  markerSettings:
                                      MarkerSettings(isVisible: true),
                                  name: 'Waist',
                                  color: kpurple,
                                  // Enable data label
                                ),
                                LineSeries<Measurement, DateTime>(
                                  dataSource: measuredata,
                                  xValueMapper: (Measurement measure, _) =>
                                      measure.time,
                                  yValueMapper: (Measurement measure, _) =>
                                      measure.hips,
                                  markerSettings:
                                      MarkerSettings(isVisible: true),
                                  name: 'Hips',
                                  color: klightPurple,
                                  // Enable data label
                                ),
                                LineSeries<Measurement, DateTime>(
                                  dataSource: measuredata,
                                  xValueMapper: (Measurement measure, _) =>
                                      measure.time,
                                  yValueMapper: (Measurement measure, _) =>
                                      measure.arms,
                                  markerSettings:
                                      MarkerSettings(isVisible: true),
                                  name: 'Arms',
                                  color: kblue,
                                  // Enable data label
                                ),
                                LineSeries<Measurement, DateTime>(
                                  dataSource: measuredata,
                                  xValueMapper: (Measurement measure, _) =>
                                      measure.time,
                                  yValueMapper: (Measurement measure, _) =>
                                      measure.thighs,
                                  markerSettings:
                                      MarkerSettings(isVisible: true),
                                  name: 'Thighs',
                                  color: klightYellow,
                                  // Enable data label
                                ),
                              ]),
                        ),
                      ),
                    ],
                  );
                },
                stream: _firestore
                    .collection('measurement')
                    .orderBy('time', descending: true)
                    .snapshots(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
