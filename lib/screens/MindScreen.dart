import 'package:flutter/material.dart';
import 'package:balance/constants.dart';
import 'package:balance/controller/NetworkAPI.dart';
import 'package:quotes/quotes.dart';

class MindScreen extends StatefulWidget {
  static String id = 'WellBeingScreenPage';
  @override
  _MindScreenState createState() => _MindScreenState();
}

class _MindScreenState extends State<MindScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
            child: Container(
              decoration: BoxDecoration(
                color: klightYellow,
                borderRadius: BorderRadius.all(Radius.circular(7.0) //
                    ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text(
                      'Positive Affirmations',
                      style: kheadingStyle,
                    ),
                    SizedBox(height: 12),
                    Text(
                      '"' + Quotes.getRandom().getContent() + ' "',
                      textAlign: TextAlign.center,
                      style: ktextStyle,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ))),
    );
  }
}
