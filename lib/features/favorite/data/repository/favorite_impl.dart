import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/features/favorite/domain/entity/favorite_entity.dart';
import 'package:movie_app/features/favorite/domain/repository/favorite_repository.dart';

class FavoriteImpl implements FavoriteRepository {
  @override
  Future<Either<FirebaseException, List<FavoriteEntity>>> getListFav() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Favorite")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("My Favorite Movie")
          .get();
      final favorites = querySnapshot.docs.map((doc) {
        return FavoriteEntity.fromMap(doc.data());
      }).toList();
      return right(favorites);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }
}
