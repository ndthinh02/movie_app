import '../../data/models/new_movie_model.dart';

class NewMovieEntity {
  bool? status;
  List<Items>? items;
  Pagination? pagination;

  NewMovieEntity({
    this.status,
    this.items,
    this.pagination,
  });
}
