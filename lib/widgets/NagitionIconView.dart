import 'package:flutter/material.dart';

class NavigationIconView {
  //item
  final BottomNavigationBarItem item;
  //title
  final String title;
  //icon path
  final String iconPath;
  //active icon path
  final String actionIconPath;

  NavigationIconView(
      {@required this.title,
      @required this.iconPath,
      @required this.actionIconPath})
      : item = BottomNavigationBarItem(
            icon: Image.asset(
              iconPath,
              width: 30,
              height: 30,
            ),
            activeIcon: Image.asset(
              actionIconPath,
              width: 30,
              height: 30,
            ),
            title: Text(title));
}
