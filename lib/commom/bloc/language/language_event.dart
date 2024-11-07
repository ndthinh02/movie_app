part of 'language_bloc.dart';

@immutable
sealed class LanguageEvent {}

class ChooseLanguage extends LanguageEvent {
  final int? index;

  ChooseLanguage({
    this.index,
  });
}
class LoadLanguageEvent extends LanguageEvent{}