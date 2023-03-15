import 'package:flutter/material.dart';

const appPurple = Color(0xFF672CBC);
const appPurpleDark = Color(0xFF040C23);
const appPurpleLight1 = Color(0xFF863ED5);
const appPurpleLight2 = Color(0xFFB9A2DB);
const appWhite = Color(0xFFFAF8FC);
const appOrange = Color(0xFFF9B091);
const appTextDark = Color(0xFFA19CC5);
const appTextLight = Color(0xFF8789A3);

ThemeData themeLight = ThemeData(
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: appPurple,
  ),
  brightness: Brightness.light,
  primaryColor: appPurple,
  scaffoldBackgroundColor: appWhite,
  appBarTheme: AppBarTheme(
    elevation: 4,
    backgroundColor: appPurple,
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: appPurpleDark),
  ),
  listTileTheme: ListTileThemeData(
    textColor: appPurpleDark,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: appPurple,
    unselectedLabelColor: Colors.grey,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: appPurple,
          width: 2,
        ),
      ),
    ),
  ),
);
ThemeData themeDark = ThemeData(
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: appWhite,
  ),
  brightness: Brightness.dark,
  primaryColor: appPurpleLight2,
  scaffoldBackgroundColor: appPurpleDark,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: appPurpleDark,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: appWhite),
    bodySmall: TextStyle(color: appTextDark),
    bodyMedium: TextStyle(color: appWhite),
  ),
  listTileTheme: ListTileThemeData(
    textColor: appWhite,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: appWhite,
    unselectedLabelColor: Colors.grey,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: appWhite,
          width: 2,
        ),
      ),
    ),
  ),
);
