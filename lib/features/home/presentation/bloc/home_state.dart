part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeMovieInitial extends HomeState {}

final class HomeLoadSuccess extends HomeState {
  final List<Items>? listItems;
  final List<DataItems>? listSingleMovie;
  final List<DataItems>? listSeriesMovie;
  final List<DataItems>? listCartoon;

  HomeLoadSuccess({
    this.listItems,
    this.listSingleMovie,
    this.listSeriesMovie,
    this.listCartoon,
  });
}

final class HomeLoadErr extends HomeState {}
