import 'package:balance/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MealCard extends StatelessWidget {
  MealCard(
      {this.description,
      this.cost,
      this.time,
      this.food,
      this.meal,
      this.mealtype});

  final String description;
  final double cost;
  final DateTime time;
  final kfoodType food;
  final kmealType mealtype;
  final kmeal meal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
          elevation: 5,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      getStringValue(meal),
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(Icons.edit)
                ],
              ),
              Divider(
                thickness: 2,
                color: Colors.black45,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Open Sans',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.attach_money),
                          Text(
                            ":  " + cost.toString(),
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Open Sans',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.access_time),
                          Text(
                            ":  " + DateFormat("kk:mm").format(time).toString(),
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Open Sans',
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.circle,
                          color: food == kfoodType.Vegan
                              ? Colors.lightGreen
                              : food == kfoodType.Veg
                                  ? Colors.amber
                                  : Colors.redAccent,
                          size: 40),
                      Icon(
                          mealtype == kmealType.Fastfood
                              ? Icons.fastfood_sharp
                              : mealtype == kmealType.Homemade
                                  ? Icons.food_bank_sharp
                                  : Icons.dinner_dining,
                          size: 40),
                    ]),
              )
            ]),
          )),
    );
  }
}
