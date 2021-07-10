import 'package:flutter/material.dart';

const kyellow = Color(0xFFECBC2E);
const klightYellow = Color(0xFFFFE86D);
const kblue = Color(0xFF2C94DA);
const klightBlue = Color(0xFF90D6FF);
const kpurple = Color(0xFF802CDA);
const klightPurple = Color(0xFFC6A2DF);
const kgrey = Colors.grey;
enum kmealType { Restaurant, Fastfood, Homemade }
enum kfoodType { Vegan, Veg, Nonveg }
enum kmeal { Breakfast, Lunch, Dinner, Snack, Exercise }

String getStringValue(kmeal meal) {
  switch (meal) {
    case kmeal.Breakfast:
      return "Breakfast";
    case kmeal.Lunch:
      return "Lunch";
    case kmeal.Dinner:
      return "Dinner";
    case kmeal.Snack:
      return "Snack";
    case kmeal.Exercise:
      return "Exercise";
    default:
      return "";
  }
}

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
