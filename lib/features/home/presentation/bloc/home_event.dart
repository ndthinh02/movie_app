part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class LoadNewMovieEvent extends HomeEvent {}

class LoadCommomMovieEvent extends HomeEvent {
  final int? limit;

  LoadCommomMovieEvent(
    this.limit,
  );
}

class LoadSeriesMovieEvent extends HomeEvent {
  final int? limit;

  LoadSeriesMovieEvent(this.limit);
}

class LoadSingleMovieEvent extends HomeEvent {
  final int? limit;

  LoadSingleMovieEvent(this.limit);
}

class LoadCartoonEvent extends HomeEvent {
  final int? limit;

  LoadCartoonEvent(this.limit);
}

class LoadTvShowsEvent extends HomeEvent {
  final int? limit;

  LoadTvShowsEvent(this.limit);
}
