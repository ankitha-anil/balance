import 'package:adv_fab/adv_fab.dart';
import 'package:balance/WidgetAnimator.dart';
import 'package:balance/constants.dart';
import 'package:balance/entity/Meal.dart';
import 'package:balance/widget/MealEdit.dart';
import 'package:balance/widget/MealInput.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class MealCard extends StatefulWidget {
  MealCard({this.meal});
  Meal meal;

  @override
  _MealCardState createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  AdvFabController controller;

  ScrollPhysics pageScrollPhysics;

  double opacityValue;

  bool isActiveReminderEmpty;

  bool isMissedReminderEmpty;

  bool showFAB;

  bool useShadowOnFAb;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10),
      child: Card(
          elevation: 5,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.meal.meal,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    iconSize: 25,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      print("in");
                      mealEditBottomModal(context, widget.meal);
                    },
                  )
                ],
              ),
              Divider(
                thickness: 2,
                color: Colors.black45,
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  widget.meal.description,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Open Sans',
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.attach_money),
                          Text(
                            ":  " + widget.meal.cost.toString(),
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
                            ":  " +
                                DateFormat.jm()
                                    .format(widget.meal.time)
                                    .toString(),
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Open Sans',
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.circle,
                          color: widget.meal.food == "Vegan"
                              ? Colors.lightGreen
                              : widget.meal.food == "Vegetarian"
                                  ? Colors.amber
                                  : Colors.redAccent,
                          size: 40),
                      Icon(
                          widget.meal.location == "Fast food"
                              ? Icons.fastfood
                              : widget.meal.location == "Homemade"
                                  ? Icons.food_bank
                                  : Icons.dinner_dining,
                          size: 40),
                    ]),
              )
            ]),
          )),
    );
  }
}

void mealEditBottomModal(context, Meal meal) {
  print(meal.description);

  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: MealEdit(
                meal: meal,
                onClose: () {
                  Navigator.pop(context);
                },
                // onConfirm: ,
              ),
            )),
      );
    },
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}
