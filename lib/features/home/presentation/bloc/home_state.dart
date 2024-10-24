part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeMovieInitial extends HomeState {}

final class HomeLoadSuccess extends HomeState {
  final List<Items>? listItems;
  final List<DataSingleItems>? listSingleMovie;
  final List<DataSeriesItems>? listSeriesMovie;
  final List<DataSingleItems>? listCartoon;

  HomeLoadSuccess({
    this.listItems,
    this.listSingleMovie,
    this.listSeriesMovie,
    this.listCartoon,
  });
}

final class HomeLoadErr extends HomeState {}
