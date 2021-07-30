import 'package:balance/SizeConfig.dart';
import 'package:balance/constants.dart';
import 'package:balance/entity/Meal.dart';
import 'package:balance/widget/MealCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:intl/intl.dart';

class MealEdit extends StatefulWidget {
  final Function onClose;
  final Function(bool isRepeated, String notificationTitle, DateTime atTime)
      onConfirm;

  final Meal meal;

  const MealEdit({
    @required this.onClose,
    this.onConfirm,
    this.meal,
    Key key,
  }) : super(key: key);

  @override
  _MealEditState createState() => _MealEditState();
}

class _MealEditState extends State<MealEdit> {
  final _firestore = FirebaseFirestore.instance;

  List<String> mealChoices;
  int mealChoiceIndex;

  List<String> locationChoices;
  int locationChoiceIndex;

  List<String> foodChoices;
  int foodChoiceIndex;

  FocusNode topLayerFocusNode;
  TextEditingController textEditingController;
  TextEditingController moneyController;

  static const _locale = 'en';
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  String description;
  String cost;
  String meal;
  String location;
  String foodtype;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    topLayerFocusNode = FocusNode();

    mealChoices = ["Breakfast", "Lunch", "Dinner", "Snack", "Exercise"];
    mealChoiceIndex = mealChoices.indexOf(widget.meal.meal);

    locationChoices = ["Homemade", "Restaurant", "Fast food"];
    locationChoiceIndex = locationChoices.indexOf(widget.meal.location);

    foodChoices = ["Vegan", "Vegetarian", "Non-vegetarian"];
    foodChoiceIndex = foodChoices.indexOf(widget.meal.food);

    description = widget.meal.description;
    cost = widget.meal.cost;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (topLayerFocusNode.hasFocus == true) {
          topLayerFocusNode.unfocus();
        }
      },
      child: Container(
        width: SizeConfig.screenWidth,
        height: 410,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: mealChoices.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ChoiceChip(
                            elevation: 3,
                            label: Text(
                              mealChoices[index],
                              style: TextStyle(
                                color: mealChoiceIndex == index
                                    ? Colors.white
                                    : Colors.black,
                                fontFamily: 'Open Sans',
                              ),
                            ),
                            selected: mealChoiceIndex == index,
                            selectedColor: Colors.grey[500],
                            onSelected: (bool selected) {
                              setState(() {
                                mealChoiceIndex = selected ? index : 0;
                              });
                            },
                            backgroundColor: Colors.white,
                          ),
                        );
                      }),
                ),
                Expanded(
                    child: TextFormField(
                  controller: textEditingController,
                  initialValue: widget.meal.description,
                  validator: (string) =>
                      string.isEmpty ? 'Enter description' : null,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      fontFamily: 'Open Sans',
                    ),
                    hintMaxLines: 1,
                  ),
                  onChanged: (string) {
                    description = string;
                  },
                )),
                Expanded(
                  child: TextFormField(
                    controller: moneyController,
                    initialValue: widget.meal.cost,
                    validator: (string) => string.isEmpty ? 'Enter cost' : null,
                    decoration: InputDecoration(
                      prefixText: _currency,
                      border: UnderlineInputBorder(),
                      labelText: 'Cost',
                      labelStyle: TextStyle(
                        fontFamily: 'Open Sans',
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (string) {
                      cost = string;
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: foodChoices.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ChoiceChip(
                            elevation: 3,
                            label: Text(
                              foodChoices[index],
                              style: TextStyle(
                                color: foodChoiceIndex == index
                                    ? Colors.white
                                    : Colors.black45,
                                fontFamily: 'Open Sans',
                              ),
                            ),
                            selected: foodChoiceIndex == index,
                            selectedColor: foodChoices[index] == "Vegan"
                                ? Colors.lightGreen
                                : foodChoices[index] == "Vegetarian"
                                    ? Colors.amberAccent
                                    : Colors.redAccent,
                            onSelected: (bool selected) {
                              setState(() {
                                foodChoiceIndex = selected ? index : 0;
                              });
                            },
                            backgroundColor: Colors.white,
                          ),
                        );
                      }),
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: locationChoices.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ChoiceChip(
                            avatar: Icon(
                              locationChoices[index] == "Fast food"
                                  ? Icons.fastfood_sharp
                                  : locationChoices[index] == "Homemade"
                                      ? Icons.food_bank_sharp
                                      : Icons.dinner_dining,
                              color: locationChoiceIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            elevation: 3,
                            label: Text(
                              locationChoices[index],
                              style: TextStyle(
                                color: locationChoiceIndex == index
                                    ? Colors.white
                                    : Colors.black,
                                fontFamily: 'Open Sans',
                              ),
                            ),
                            selected: locationChoiceIndex == index,
                            selectedColor: Colors.grey[800],
                            onSelected: (bool selected) {
                              setState(() {
                                locationChoiceIndex = selected ? index : 0;
                              });
                            },
                            backgroundColor: Colors.white,
                          ),
                        );
                      }),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        color: Colors.red,
                        iconSize: 40,
                        icon: Icon(
                          Icons.delete,
                          color: Colors.grey[600],
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NetworkGiffyDialog(
                                  image: Image.network(
                                    "https://cdn.dribbble.com/users/592004/screenshots/2953817/___.gif",
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text('Are you sure?',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600)),
                                  description: Text(
                                    'Do you want to delete this meal?',
                                    textAlign: TextAlign.center,
                                  ),
                                  entryAnimation: EntryAnimation.BOTTOM,
                                  onOkButtonPressed: () {
                                    _firestore
                                        .collection("meals")
                                        .where("description",
                                            isEqualTo: widget.meal.description)
                                        .get()
                                        .then((value) {
                                      value.docs.forEach((element) {
                                        _firestore
                                            .collection('meals')
                                            .doc(element.id)
                                            .delete();
                                      });
                                    });
                                    Navigator.of(context).pop();
                                  },
                                );
                              });

                          widget.onClose();
                        }),
                    IconButton(
                        iconSize: 40,
                        icon: Icon(
                          Icons.check_circle,
                          color: Colors.grey[600],
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            meal = mealChoices[mealChoiceIndex];
                            foodtype = foodChoices[foodChoiceIndex];
                            location = locationChoices[locationChoiceIndex];

                            try {
                              _firestore
                                  .collection("meals")
                                  .where("description",
                                      isEqualTo: widget.meal.description)
                                  .get()
                                  .then((value) {
                                value.docs.forEach((element) {
                                  _firestore
                                      .collection('meals')
                                      .doc(element.id)
                                      .update({
                                    'description': description,
                                    'time': widget.meal.time,
                                    'location': location,
                                    'meal': meal,
                                    'food': foodtype,
                                    'cost': cost,
                                  });
                                });
                              });
                            } catch (e) {
                              print(e);
                            } //Database stuff

                            MealCard newMeal = new MealCard(
                                meal: Meal(
                              description: description,
                              time: widget.meal.time,
                              location: location,
                              meal: meal,
                              food: foodtype,
                              cost: cost,
                            ));
                            setState(() {
                              mealList.add(newMeal);
                            });
                            widget.onClose();
                          }
                        }),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
