import 'package:flutter/material.dart';
import 'package:balance/constants.dart';

class AccountScreen extends StatefulWidget {
  static String id = 'AccountScreenPage';
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
