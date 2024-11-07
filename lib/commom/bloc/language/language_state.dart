part of 'language_bloc.dart';

@immutable
class LanguageState {
  final Locale? locale;
  final int? index;
  final List<bool>? widgetVisibility;

  const LanguageState({
    this.locale,
    this.index,
    this.widgetVisibility,
  });
}
