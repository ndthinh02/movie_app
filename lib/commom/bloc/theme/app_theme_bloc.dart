import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../share_preferences/app_share_preferences.dart';

part 'app_theme_event.dart';

part 'app_theme_state.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  AppThemeBloc() : super(const AppThemeState()) {
    on<ToggleChangeTheme>(
      (event, emit) async {
        isDarkTheme = !isDarkTheme;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(AppSharePreferences.keyDarkMode, isDarkTheme);
        emit(AppThemeState(isDarkTheme: isDarkTheme));
      },
    );
    on<LoadThemeEvent>(
      (event, emit) async {
        final prefs = await SharedPreferences.getInstance();
        final theme = prefs.getBool(AppSharePreferences.keyDarkMode) ?? true;
        emit(AppThemeState(isDarkTheme: theme));
      },
    );
  }

  bool isDarkTheme = true;
}
