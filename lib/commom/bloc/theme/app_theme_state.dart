part of 'app_theme_bloc.dart';

@immutable
class AppThemeState {
  final bool? isDarkTheme;

  const AppThemeState({
    this.isDarkTheme = true,
  });
}
