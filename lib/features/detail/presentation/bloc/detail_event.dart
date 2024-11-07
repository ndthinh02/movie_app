part of 'detail_bloc.dart';

@immutable
sealed class DetailEvent {}

class LoadDetailEvent extends DetailEvent {
  final String? slugMovie;

  LoadDetailEvent({
    this.slugMovie,
  });
}

class AddOrRemoveFav extends DetailEvent {
  late final FavoriteEntity? favoriteEntity;
  final bool? isFav;

  AddOrRemoveFav({
    this.favoriteEntity,
    this.isFav,
  });
}

class GetFavoriteEvent extends DetailEvent {
  final String? name;

  GetFavoriteEvent({
    this.name,
  });
}
