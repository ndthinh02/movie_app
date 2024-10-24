import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: AppColors.colorPrimary,
      fontFamily: 'InriaSans',
      appBarTheme: appBarTheme());
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: AppColors.colorPrimary,
    elevation: 0,
    centerTitle: true,
  );
}
