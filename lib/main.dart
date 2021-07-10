import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:balance/screens/AccountScreen.dart';
import 'package:balance/screens/FinanceScreen.dart';
import 'package:balance/screens/FoodScreen.dart';
import 'package:balance/screens/MeasurementResultScreen.dart';
import 'package:balance/screens/MeasurementScreen.dart';
import 'package:balance/screens/MindScreen.dart';
import 'package:balance/screens/LoadingScreen.dart';

import 'screens/MainScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LetsDoThis());
}

class LetsDoThis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MainScreen.id,
      routes: {
        LoadingScreen.id: (context) => LoadingScreen(),
        FoodScreen.id: (context) => FoodScreen(),
        MainScreen.id: (context) => MainScreen(),
        MeasurementScreen.id: (context) => MeasurementScreen(),
        MeasurementResultScreen.id: (context) => MeasurementResultScreen(),
        AccountScreen.id: (context) => AccountScreen(),
        MindScreen.id: (context) => MindScreen(),
        FinanceScreen.id: (context) => FinanceScreen(),
      },
    );
  }
}
