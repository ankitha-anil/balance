import 'package:flutter/material.dart';
import 'package:balance/constants.dart';

class FinanceScreen extends StatefulWidget {
  static String id = 'FinanceScreenPage';
  @override
  _FinanceScreenState createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: klightPurple,
      child: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: [],
      ))),
    );
  }
}
