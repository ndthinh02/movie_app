import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/features/favorite/domain/repository/favorite_repository.dart';

import '../entity/favorite_entity.dart';

class FavoriteUseCase {
  FavoriteRepository _repo;

  FavoriteUseCase(this._repo);

  Future<Either<FirebaseException, List<FavoriteEntity>>> getListFav() {
    return _repo.getListFav();
  }
}
