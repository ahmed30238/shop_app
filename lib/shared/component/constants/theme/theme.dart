import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var theme = ThemeData(
 appBarTheme: const AppBarTheme(
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
    color: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.grey,
      selectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
);
var darkTheme = ThemeData(
  // primarySwatch: MaterialColor(0, swatch),
  appBarTheme: const AppBarTheme(
    actionsIconTheme: IconThemeData(
      color: Colors.white,
    ),
    color: Colors.black,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed),
  scaffoldBackgroundColor: Colors.black,
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
);
