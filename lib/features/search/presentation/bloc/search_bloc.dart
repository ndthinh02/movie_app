import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/config/themes/app_themes.dart';

import '../../../home/data/models/commom_movie_model.dart';
import '../../domain/usecases/search_usecase.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase _useCase;

  SearchBloc(this._useCase) : super(SearchInitial()) {
    on<SearchListMovie>(
      (event, emit) => _onSearchListMovieEvent(event, emit),
    );
    on<ClearListSearch>(
      (event, emit) => _onClearListSearchEvent(event, emit),
    );
  }

  _onSearchListMovieEvent(SearchListMovie event, Emitter emit) async {
    emit(
      SearchInitial(
        isSearch: false,
      ),
    );
    emit(
      SearchInitial(
        isSearch: true,
      ),
    );
    if (event.keyword == "") {
      emit(
        SearchSuccess(
          listSearch: const [],
        ),
      );
    }
    final result = await _useCase.getListSearchMovie(
      keyword: event.keyword,
      limit: 20,
    );

    result.fold((err) {
      emit(SearchErr());
      logger.d(err);
      return left(err);
    }, (data) {
      emit(
        SearchSuccess(
          listSearch: data.data?.items,
        ),
      );
      return right(data);
    });
  }

  _onClearListSearchEvent(ClearListSearch event, Emitter emit) {
    emit(SearchSuccess(listSearch: const []));
  }
}
