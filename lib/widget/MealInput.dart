import 'package:balance/SizeConfig.dart';
import 'package:balance/constants.dart';
import 'package:balance/entity/Meal.dart';
import 'package:balance/widget/MealCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MealInput extends StatefulWidget {
  final Function onClose;
  final DateTime selectedDate;

  const MealInput({
    @required this.onClose,
    this.selectedDate,
    Key key,
  }) : super(key: key);

  @override
  _MealInputState createState() => _MealInputState();
}

class _MealInputState extends State<MealInput> {
  final _firestore = FirebaseFirestore.instance;

  bool indexCheck;

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
    textEditingController = TextEditingController();
    mealChoiceIndex = 0;
    mealChoices = ["Breakfast", "Lunch", "Dinner", "Snack", "Exercise"];

    locationChoiceIndex = 0;
    locationChoices = ["Homemade", "Restaurant", "Fast food"];

    foodChoiceIndex = 0;
    foodChoices = ["Vegan", "Vegetarian", "Non-vegetarian"];
    indexCheck = true;
    cost = "0";
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
                            disabledColor: Colors.grey[400],
                            selectedColor: Colors.grey[600],
                            onSelected: (bool selected) {
                              setState(() {
                                mealChoiceIndex = selected ? index : null;
                                indexCheck = false;
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
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      fontFamily: 'Open Sans',
                    ),
                    hintMaxLines: 1,
                  ),
                  validator: (string) =>
                      string.isEmpty ? 'Enter description' : null,
                  onChanged: (string) {
                    description = string;
                  },
                )),
                Expanded(
                  child: TextField(
                    controller: moneyController,
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

                            MealCard newMeal = new MealCard(
                                meal: Meal(
                              description: description,
                              time: DateTime.now(),
                              location: location,
                              meal: meal,
                              food: foodtype,
                              cost: cost,
                            ));
                            setState(() {
                              mealList.add(newMeal);
                            });
                            try {
                              _firestore.collection('meals').add({
                                'description': description,
                                'time': DateTime.now(),
                                'location': location,
                                'meal': meal,
                                'food': foodtype,
                                'cost': cost,
                              });
                            } catch (e) {
                              print(e);
                            }
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
