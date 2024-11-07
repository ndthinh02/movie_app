import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/commom/share_preferences/app_share_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_event.dart';

part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState()) {
    on<ChooseLanguage>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(AppSharePreferences.keyLanguage, event.index ?? 0);
      emit(
        LanguageState(
          locale: event.index == 0 ? const Locale('vi') : const Locale('en'),
        ),
      );
    });
    on<LoadLanguageEvent>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final language = prefs.getInt(AppSharePreferences.keyLanguage);
      emit(
        LanguageState(
          locale: language == 0 ? const Locale('vi') : const Locale('en'),
        ),
      );
    });
  }
}
