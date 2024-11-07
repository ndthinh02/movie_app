import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../entity/auth_entity.dart';

abstract class AuthRepo {
  Future<Either<String, UserCredential>> signupWithEmail(
      {required AuthEntity authEntity});

  Future<Either<FirebaseException, UserCredential>> signInWithEmail(
      {required AuthEntity authEntity});

  Future<Either<FirebaseException, UserCredential>> signInWithGoogle();

  Future<Either<FirebaseException, UserCredential>> signInWithFb();
}
