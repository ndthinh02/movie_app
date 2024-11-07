import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../entity/favorite_entity.dart';

abstract class FavoriteRepository {
  Future<Either<FirebaseException, List<FavoriteEntity>>> getListFav();
}
