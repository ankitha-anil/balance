import 'package:balance/screens/MeasurementResultScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:balance/Measurements.dart';
import 'package:balance/constants.dart';
import 'package:balance/widget/Measurecard.dart';

class MeasurementScreen extends StatefulWidget {
  static String id = 'WeightScreenPage';
  @override
  _MeasurementScreenState createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  double weight = 55;
  double waist = 20;
  double hips = 30;
  double thighs = 15;
  double arms = 10;

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Text('Weekly Measurement', style: kheadingStyle),
          Expanded(
            child: ReusableWidget(
              color: klightPurple,
              value: weight,
              metric: 'kg',
              precision: 2,
              text: 'Weight',
              slider: Slider(
                value: weight.toDouble(),
                min: 40,
                max: 70,
                inactiveColor: Color(0xFFC2C2C2),
                onChanged: (double newValue) {
                  setState(() {
                    weight = newValue;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableWidget(
                    color: klightYellow,
                    value: waist,
                    metric: 'cm',
                    precision: 1,
                    text: 'Waist',
                    slider: Slider(
                      value: waist.toDouble(),
                      min: 10,
                      max: 30,
                      inactiveColor: Color(0xFFC2C2C2),
                      onChanged: (double newValue) {
                        setState(() {
                          waist = newValue;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableWidget(
                    color: klightBlue,
                    value: hips,
                    metric: 'cm',
                    precision: 1,
                    text: 'Hips',
                    slider: Slider(
                      value: hips.toDouble(),
                      min: 10,
                      max: 40,
                      inactiveColor: Color(0xFFC2C2C2),
                      onChanged: (double newValue) {
                        setState(() {
                          hips = newValue;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(children: [
              Expanded(
                child: ReusableWidget(
                  color: klightBlue,
                  value: thighs,
                  metric: 'cm',
                  precision: 1,
                  text: 'Thighs',
                  slider: Slider(
                    value: thighs.toDouble(),
                    min: 10,
                    max: 20,
                    inactiveColor: Color(0xFFC2C2C2),
                    onChanged: (double newValue) {
                      setState(() {
                        thighs = newValue;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ReusableWidget(
                  color: klightYellow,
                  value: arms,
                  metric: 'cm',
                  precision: 1,
                  text: 'Arms',
                  slider: Slider(
                    value: arms.toDouble(),
                    min: 10,
                    max: 30,
                    inactiveColor: Color(0xFFC2C2C2),
                    onChanged: (double newValue) {
                      setState(() {
                        arms = newValue;
                      });
                    },
                  ),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.lightGreen,
              onPressed: () {
                Measurement measurement = new Measurement(
                    time: DateTime.now(),
                    weight: weight,
                    waist: waist,
                    hips: hips,
                    arms: arms,
                    thighs: thighs);

                measurement.printElements();

                try {
                  _firestore.collection('measurement').add({
                    'time': DateTime.now(),
                    'weight': weight,
                    'hips': hips,
                    'waist': waist,
                    'arms': arms,
                    'thighs': thighs,
                  });
                } catch (e) {
                  print(e);
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MeasurementResultScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Text('Submit', style: klabelTextStyle),
                    Icon(
                      Icons.check_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
