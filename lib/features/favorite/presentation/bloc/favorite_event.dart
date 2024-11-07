part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

class GetListFavorite extends FavoriteEvent {
  GetListFavorite();
}
