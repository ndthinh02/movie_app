part of 'detail_bloc.dart';

@immutable
sealed class DetailState {}

final class DetailInitial extends DetailState {}

final class DetailLoadSuccess extends DetailState {
  final DetailEntity? detail;
  final bool? isFav;
  final List<FavoriteEntity>? listFav;

  DetailLoadSuccess({
    this.detail,
    this.isFav,
    this.listFav,
  });
}

final class DetailLoadErr extends DetailState {
  final String? err;

  DetailLoadErr({
    this.err,
  });
}
