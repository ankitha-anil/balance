import 'package:balance/entity/Meal.dart';
import 'package:balance/widget/MealCard.dart';
import 'package:flutter/material.dart';

const kyellow = Color(0xFFECBC2E);
const klightYellow = Color(0xFFFFE86D);
const kblue = Color(0xFF2C94DA);
const klightBlue = Color(0xFF90D6FF);
const kpurple = Color(0xFF802CDA);
const klightPurple = Color(0xFFC6A2DF);
const kgrey = Colors.grey;
// enum kmealType { Restaurant, Fastfood, Homemade}
// enum kfoodType { Vegan, Veg, Nonveg }
// enum kmeal { Breakfast, Lunch, Dinner, Snack, Exercise }

List<MealCard> mealList = [
  MealCard(
      meal: Meal(
          meal: "Breakfast",
          description: 'Yoghurt with blueberries and grapes and strawberries',
          cost: "18.90",
          time: DateTime.now(),
          location: "Restaurant",
          food: "Vegetarian"))
];

const kheadingStyle = TextStyle(
    decoration: TextDecoration.none,
    fontSize: 20,
    fontFamily: 'Open Sans',
    fontWeight: FontWeight.bold,
    color: Colors.black);

const ktextStyle = TextStyle(
    decoration: TextDecoration.none,
    fontSize: 18,
    fontFamily: 'Open Sans',
    fontWeight: FontWeight.normal,
    color: Colors.black45);

const klabelTextStyle = TextStyle(
  decoration: TextDecoration.none,
  fontSize: 19,
  fontFamily: 'Open Sans',
  fontWeight: FontWeight.normal,
  color: Colors.white,
);

const knumberTextStyle = TextStyle(
  decoration: TextDecoration.none,
  fontSize: 40,
  fontFamily: 'Open Sans',
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
