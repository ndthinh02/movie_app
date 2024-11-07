import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';

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
    on<LoadSingleMovieEvent>(
      (event, emit) => _onLoadSingleMovieEvent(event, emit),
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
    on<Init>(
      (event, emit) => _onInit(event, emit),
    );
  }

  List<Items> _listNewMovie = [];
  List<DataItems> listSingle = [];
  List<DataItems> _listCarton = [];
  List<DataItems> _listSeries = [];
  int _page = -1;
  final PagingController<int, DataItems> controller = PagingController(
    firstPageKey: 0,
  );

  _onInit(Init event, Emitter emit) {
    add(LoadNewMovieEvent());
    add(LoadSingleMovieEvent(10));
    add(LoadCartoonEvent(10));
    add(LoadSeriesMovieEvent(10));
  }

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

  _onLoadSingleMovieEvent(LoadSingleMovieEvent event, Emitter emit) async {
    final result = await _useCase.executeSingleMovie(event.limit, 1);

    result.fold((err) {
      emit(HomeLoadErr());
      return left(err);
    }, (data) {
      listSingle = data.data!.items ?? [];
      emit(
        HomeLoadSuccess(
          listItems: _listNewMovie,
          listSingleMovie: data.data!.items,
          listCartoon: _listCarton,
          listSeriesMovie: _listSeries,
        ),
      );
      return right(data);
    });
  }

  _onLoadSeriesMovieEvent(LoadSeriesMovieEvent event, Emitter emit) async {
    final result = await _useCase.executeSeriesMovie(event.limit, 1);
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
            listSingleMovie: listSingle,
            listCartoon: _listCarton,
            listSeriesMovie: data.data!.items,
          ),
        );
        return right(data);
      },
    );
  }

  _onLoadCartoonEvent(LoadCartoonEvent event, Emitter emit) async {
    final result = await _useCase.executeCartoon(event.limit, 1);
    result.fold(
      (err) {
        emit(HomeLoadErr());
        return left(err);
      },
      (data) {
        _listCarton = data.data?.items ?? [];
        emit(
          HomeLoadSuccess(
            listItems: _listNewMovie,
            listSingleMovie: listSingle,
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
