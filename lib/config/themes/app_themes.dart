import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../colors/app_colors.dart';

var logger = Logger();

ThemeData lightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.primaryBackgroundHome,
    brightness: Brightness.light,
    fontFamily: 'InriaSans',
    textTheme: lightTextTheme(),
    appBarTheme: appBarThemeLight(),
    iconTheme: iconLight(),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.colorPrimary,
    brightness: Brightness.dark,
    fontFamily: 'InriaSans',
    textTheme: darkTextTheme(),
    iconTheme: iconDark(),
    appBarTheme: appBarThemeDark(),
  );
}

IconThemeData iconDark() {
  return const IconThemeData(color: Colors.white);
}

IconThemeData iconLight() {
  return const IconThemeData(color: Colors.black);
}

AppBarTheme appBarThemeDark() {
  return AppBarTheme(
    color: AppColors.colorPrimary,
    elevation: 0,
    centerTitle: true,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'InriaSans',
    ),
  );
}

AppBarTheme appBarThemeLight() {
  return const AppBarTheme(
    color: AppColors.primaryBackgroundHome,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'InriaSans',
    ),
  );
}

TextTheme lightTextTheme() {
  return const TextTheme(
    headlineSmall: TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontFamily: 'InriaSans',
      fontWeight: FontWeight.w900,
    ),
    headlineLarge: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.w900,
    ),
  );
}

TextTheme darkTextTheme() {
  return const TextTheme(
    headlineSmall: TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: 'InriaSans',
      fontWeight: FontWeight.w600,
    ),
    headlineLarge: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.w900,
    ),
  );
}
