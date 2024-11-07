part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

class LoadListFav extends FavoriteState {}

class LoadListFavSuccess extends FavoriteState {
  final List<FavoriteEntity>? list;

  LoadListFavSuccess({
    this.list,
  });
}

class LoadListFavFailed extends FavoriteState {}
