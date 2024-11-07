import 'package:dartz/dartz.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:movie_app/features/setting/data/data_source/user_service.dart';
import 'package:movie_app/features/setting/domain/entities/user_entity.dart';
import 'package:movie_app/features/setting/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserService _service;

  UserRepositoryImpl(this._service);

  @override
  Future<Either<FirebaseException, UserEntity>> getUser() async {
    return _service.getUser();
  }
}
