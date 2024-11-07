import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/features/auth/data/data_source/auth_service.dart';
import 'package:movie_app/features/auth/domain/entity/auth_entity.dart';
import 'package:movie_app/features/auth/domain/repository/signin_repo.dart';

class AuthImpl implements AuthRepo {
  AuthService _service;

  AuthImpl(this._service);

  @override
  Future<Either<String, UserCredential>> signupWithEmail({
    required AuthEntity authEntity,
  }) async {
    return await _service.signupWithEmail(auth: authEntity);
  }

  @override
  Future<Either<FirebaseException, UserCredential>> signInWithEmail({
    required AuthEntity authEntity,
  }) async {
    return await _service.signInWithEmail(auth: authEntity);
  }

  @override
  Future<Either<FirebaseException, UserCredential>> signInWithFb() async {
    return await _service.signInWithFb();
  }

  Future<Either<FirebaseException, UserCredential>> signInWithGoogle() async {
    return await _service.signInWithGoogle();
  }

}
