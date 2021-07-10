import 'package:balance/widget/MealCard.dart';
import 'package:flutter/material.dart';
import 'package:balance/constants.dart';

class FoodScreen extends StatefulWidget {
  static String id = 'FoodScreenPage';
  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  List<MealCard> mealList = [
    MealCard(
        meal: kmeal.Breakfast,
        description: 'Yoghurt with blueberries and grapes and strawberries',
        cost: 18.90,
        time: DateTime.now(),
        mealtype: kmealType.Restaurant,
        food: kfoodType.Veg)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: klightBlue,
      child: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: [
          for (int i = 0; i < mealList.length; i++) mealList[i],
          FloatingActionButton(
              backgroundColor: klightPurple,
              child: Icon(Icons.add, size: 40),
              elevation: 5,
              onPressed: () {
                setState(() {
                  mealList.add(MealCard(
                      meal: kmeal.Lunch,
                      description:
                          'Rice with noice pineapple curry and ladies finger fry',
                      cost: 0.90,
                      time: DateTime.now().add(const Duration(minutes: 125)),
                      mealtype: kmealType.Homemade,
                      food: kfoodType.Vegan));
                });
              })
        ],
      ))),
    );
  }
}
