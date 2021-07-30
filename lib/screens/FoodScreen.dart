import 'dart:math';

import 'package:balance/WidgetAnimator.dart';
import 'package:balance/entity/Meal.dart';
import 'package:balance/widget/MealInput.dart';
import 'package:balance/widget/MealCard.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:balance/constants.dart';
import 'package:adv_fab/adv_fab.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class FoodScreen extends StatefulWidget {
  static String id = 'FoodScreenPage';
  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final _firestore = FirebaseFirestore.instance;

  AdvFabController controller;
  ScrollPhysics pageScrollPhysics;
  double opacityValue;
  bool isActiveReminderEmpty;
  bool isMissedReminderEmpty;
  bool showFAB;
  bool useShadowOnFAb;

  DateTime selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    opacityValue = 1;
    controller = AdvFabController();
    pageScrollPhysics = BouncingScrollPhysics();
    useShadowOnFAb = false;
    // isActiveReminderEmpty = Hive.box('reminderBox').isEmpty ? true : false;
    // isMissedReminderEmpty = true;
    showFAB = true;

    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    initializeDateFormatting('en');

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        floatingActionButton: showFAB
            ? WidgetAnimator(
                animateFromTop: false,
                duration: Duration(milliseconds: 600),
                child: SingleChildScrollView(
                  child: AdvFab(
                    animationDuration: Duration(milliseconds: 350),
                    useElevation: useShadowOnFAb,
                    showLogs: false,
                    floatingActionButtonExpendedWidth: 93,
                    controller: controller,
                    onFloatingActionButtonTapped: () {
                      controller.setExpandedWidgetConfiguration(
                          withChild: MealInput(
                            onClose: () {
                              controller.collapseFAB();
                              Future.delayed(Duration(milliseconds: 500), () {
                                setState(() {
                                  useShadowOnFAb = false;
                                  pageScrollPhysics = BouncingScrollPhysics();
                                  opacityValue = 1;
                                });
                              });
                            },
                          ),
                          heightToExpandTo: 55,
                          expendedBackgroundColor: Colors.white);

                      if (controller.isCollapsed == true) {
                        controller.expandFAB();
                        setState(() {
                          useShadowOnFAb = true;
                          pageScrollPhysics = BouncingScrollPhysics();
                          opacityValue = 0;
                        });
                      } else {
                        controller.collapseFAB();
                      }
                    },
                    collapsedColor: klightPurple,
                    floatingActionButtonIcon: Icons.add,
                    floatingActionButtonIconColor: Colors.white,
                  ),
                ),
              )
            : null,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Search bar", style: kheadingStyle),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 3),
                child: Container(
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CalendarTimeline(
                      initialDate: selectedDate,
                      firstDate: DateTime.parse(DateTime.now()
                          .subtract(const Duration(days: 7 * 30))
                          .toString()),
                      lastDate: DateTime.parse(DateTime.now()
                          .add(const Duration(days: 7 * 30))
                          .toString()),
                      onDateSelected: (date) {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                      leftMargin: 20,
                      monthColor: Colors.blueGrey,
                      dayColor: klightBlue,
                      activeDayColor: Colors.white,
                      activeBackgroundDayColor: klightBlue,
                      dotsColor: klightBlue,
                      //selectableDayPredicate: (date) => date.day != 23,
                      locale: 'en_ISO',
                    ),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                      ));
                    }

                    final meals = snapshot.data.docs;
                    List<MealCard> mealCards = [];

                    for (var meal in meals) {
                      if (DateFormat('yyyy-MM-dd')
                              .format(meal['time'].toDate()) ==
                          DateFormat('yyyy-MM-dd').format(selectedDate)) {
                        final currentMeal = MealCard(
                            meal: Meal(
                          description: meal['description'],
                          time: meal['time'].toDate(),
                          location: meal['location'],
                          meal: meal['meal'],
                          food: meal['food'],
                          cost: meal['cost'],
                        ));

                        mealCards.add(currentMeal);
                      }
                    }

                    return Column(children: [
                      mealCards.isNotEmpty
                          ? Container(child: _buildCard(mealCards))
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: Text('No input',
                                    style: kheadingStyle.copyWith(
                                        color: Colors.grey)),
                              ),
                            )
                    ]);
                  },
                  stream: _firestore
                      .collection('meals')
                      .orderBy('time')
                      .snapshots()),
              //for (int i = 0; i < mealList.length; i++) mealList[i],
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildCard(List<MealCard> mealList) {
  List<Widget> chips = new List();

  for (int i = 0; i < mealList.length; i++) {
    chips.add(mealList[i]);
  }

  return ListView(
    children: chips,
    shrinkWrap: true,
  );
}
