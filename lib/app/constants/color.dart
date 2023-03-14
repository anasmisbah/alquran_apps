import 'package:flutter/material.dart';

const appPurple = Color(0xFF672CBC);
const appPurpleDark = Color(0xFF040C23);
const appPurpleLight1 = Color(0xFF863ED5);
const appPurpleLight2 = Color(0xFFB9A2DB);
const appWhite = Color(0xFFFAF8FC);
const appOrange = Color(0xFFF9B091);
const appTextDark = Color(0xFFA19CC5);

ThemeData themeLight = ThemeData(
  primaryColor: appPurple,
  scaffoldBackgroundColor: appWhite,
  appBarTheme: AppBarTheme(
    backgroundColor: appPurple,
  ),
);
ThemeData themeDark = ThemeData(
    primaryColor: appPurpleLight2,
    scaffoldBackgroundColor: appPurpleDark,
    appBarTheme: AppBarTheme(
      backgroundColor: appPurpleDark,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: appWhite),
      bodySmall: TextStyle(color: appTextDark),
      bodyMedium: TextStyle(color: appWhite),
    ));
