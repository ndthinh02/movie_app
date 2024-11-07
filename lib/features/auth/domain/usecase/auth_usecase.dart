import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/features/auth/domain/entity/auth_entity.dart';

import '../repository/signin_repo.dart';

class AuthUseCase {
  AuthRepo repo;

  AuthUseCase(this.repo);

  Future<Either<String, UserCredential>> signupWithEmail(
      {required AuthEntity authEntity}) {
    return repo.signupWithEmail(authEntity: authEntity);
  }

  Future<Either<FirebaseException, UserCredential>> signInWithEmail(
      {required AuthEntity authEntity}) {
    return repo.signInWithEmail(authEntity: authEntity);
  }

  Future<Either<FirebaseException, UserCredential>> signInWithGoogle() {
    return repo.signInWithGoogle();
  }

  Future<Either<FirebaseException, UserCredential>> signInWithFb() {
    return repo.signInWithFb();
  }
}
