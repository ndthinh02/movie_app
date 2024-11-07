part of 'app_theme_bloc.dart';

@immutable
sealed class AppThemeEvent {}

class ToggleChangeTheme extends AppThemeEvent {}

class LoadThemeEvent extends AppThemeEvent{}
