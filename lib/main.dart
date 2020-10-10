import 'package:flutter/material.dart';
import 'package:osc_demo/constants/constants.dart' show AppColors;
import 'package:osc_demo/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '开源中国',
      theme: ThemeData(
        primaryColor: Color(AppColors.AppTheme),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
