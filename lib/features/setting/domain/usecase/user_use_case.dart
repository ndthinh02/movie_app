import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../entities/user_entity.dart';
import '../repository/user_repository.dart';

class UserUseCase {
  final UserRepository _user;

  UserUseCase(this._user);

  Future<Either<FirebaseException, UserEntity>> getUser() async {
    return _user.getUser();
  }
}
