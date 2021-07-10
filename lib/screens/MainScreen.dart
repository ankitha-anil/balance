import 'package:flutter/material.dart';
import 'package:balance/screens/AccountScreen.dart';
import 'package:balance/screens/FinanceScreen.dart';
import 'package:balance/screens/FoodScreen.dart';
import 'package:balance/screens/MeasurementScreen.dart';
import 'package:balance/screens/MindScreen.dart';
import 'package:balance/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainScreen extends StatefulWidget {
  static String id = 'MainScreenPage';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 2);

  List<Widget> _buildScreens() {
    return [
      FinanceScreen(),
      FoodScreen(),
      MindScreen(),
      MeasurementScreen(),
      AccountScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.attach_money_rounded,
          size: 35,
        ),
        title: ("Finance"),
        activeColorPrimary: kpurple,
        inactiveColorPrimary: kgrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.restaurant_outlined,
          size: 35,
        ),
        title: ("Food"),
        activeColorPrimary: kblue,
        inactiveColorPrimary: kgrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.psychology,
          size: 35,
        ),
        title: ("Mind"),
        activeColorPrimary: kyellow,
        inactiveColorPrimary: kgrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.fitness_center_outlined,
          size: 35,
        ),
        title: ("Body"),
        activeColorPrimary: kblue,
        inactiveColorPrimary: kgrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.person,
          size: 35,
        ),
        title: ("Account"),
        activeColorPrimary: kpurple,
        inactiveColorPrimary: kgrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.grey,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style12, // Choose the nav bar style with this property.
    );
  }
}
