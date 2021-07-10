import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:balance/constants.dart';
import 'package:balance/controller/NetworkAPI.dart';
import 'package:balance/screens/MainScreen.dart';
import 'package:balance/screens/MindScreen.dart';

import '../constants.dart';

class LoadingScreen extends StatefulWidget {
  static String id = 'loadingscreen';
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    //callAffirmation();
  }

  void callAffirmation() async {
    String affirmation;
    Network networkAffirmation = Network(
        url: 'https://dulce-affirmations-api.herokuapp.com/affirmation');
    var data = await networkAffirmation.getData();
    setState(() {
      affirmation = data[0]["phrase"];
    });

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MainScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SpinKitRipple(
      color: kblue,
      size: 100.0,
    )));
  }
}
