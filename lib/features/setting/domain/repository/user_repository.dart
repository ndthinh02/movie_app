import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/features/setting/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<FirebaseException, UserEntity>> getUser();
}
