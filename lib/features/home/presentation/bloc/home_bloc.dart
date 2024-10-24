import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/features/home/data/models/series_model.dart';

import '../../data/models/commom_movie_model.dart';
import '../../data/models/new_movie_model.dart';
import '../../domain/usecase/home_usecase.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase _useCase;

  HomeBloc(this._useCase) : super(HomeMovieInitial()) {
    on<LoadNewMovieEvent>(
      (event, emit) => _onLoadNewMovieEvent(event, emit),
    );
    on<LoadCommomMovieEvent>(
      (event, emit) => _onLoadCommomMovieEvent(event, emit),
    );
    on<LoadSeriesMovieEvent>(
      (event, emit) => _onLoadSeriesMovieEvent(event, emit),
    );
    on<LoadCartoonEvent>(
      (event, emit) => _onLoadCartoonEvent(event, emit),
    );
    on<LoadTvShowsEvent>(
      (event, emit) => _onLoadTvShowsEvent(event, emit),
    );
  }

  List<Items> _listNewMovie = [];
  List<DataSingleItems> _listSingle = [];
  List<DataSingleItems> _listCarton = [];
  List<DataSeriesItems> _listSeries = [];

  _onLoadNewMovieEvent(LoadNewMovieEvent event, Emitter emit) async {
    Future.delayed(const Duration(seconds: 2));
    emit(HomeMovieInitial());
    final result = await _useCase.execute();
    result.fold(
      (err) {
        emit(HomeLoadErr());
        return left(err);
      },
      (data) {
        _listNewMovie = data.items ?? [];
        emit(
          HomeLoadSuccess(
            listItems: data.items,
          ),
        );
        return right(data);
      },
    );
  }

  _onLoadCommomMovieEvent(LoadCommomMovieEvent event, Emitter emit) async {
    // Future.delayed(const Duration(seconds: 2));
    // emit(HomeMovieInitial());

    final result =
        await _useCase.executeSingleMovie(event.limit).whenComplete(() async {
      add(
        LoadSeriesMovieEvent(10),
      );
      add(
        LoadCartoonEvent(10),
      );
    });
    result.fold((err) {
      emit(HomeLoadErr());
      return left(err);
    }, (data) {
      _listSingle = data.data!.items ?? [];
      emit(
        HomeLoadSuccess(
          listItems: _listNewMovie,
          listSingleMovie: data.data!.items,
          listCartoon: _listCarton,
        ),
      );
      return right(data);
    });
  }

  _onLoadSeriesMovieEvent(LoadSeriesMovieEvent event, Emitter emit) async {
    final result = await _useCase.executeSeriesMovie(event.limit);
    result.fold(
      (err) {
        emit(HomeLoadErr());
        return left(err);
      },
      (data) {
        _listSeries = data.data!.items ?? [];
        emit(
          HomeLoadSuccess(
            listItems: _listNewMovie,
            listSingleMovie: _listSingle,
            listCartoon: _listCarton,
            listSeriesMovie: data.data!.items,
          ),
        );
        return right(data);
      },
    );
  }

  _onLoadCartoonEvent(LoadCartoonEvent event, Emitter emit) async {
    final result = await _useCase.executeCartoon(event.limit);
    result.fold(
      (err) {
        emit(HomeLoadErr());
        return left(err);
      },
      (data) {
        emit(
          HomeLoadSuccess(
            listItems: _listNewMovie,
            listSingleMovie: _listSingle,
            listSeriesMovie: _listSeries,
            listCartoon: data.data?.items,
          ),
        );
        return right(data);
      },
    );
  }

  _onLoadTvShowsEvent(LoadTvShowsEvent event, Emitter emit) async {}
}
