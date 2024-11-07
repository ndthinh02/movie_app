import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_app/features/auth/domain/entity/auth_entity.dart';

class AuthService {
  final FirebaseAuth auth;

  AuthService(this.auth);

  Future<Either<String, UserCredential>> signupWithEmail(
      {required AuthEntity auth}) async {
    try {
      final credential = await this.auth.createUserWithEmailAndPassword(
            email: auth.email ?? '',
            password: auth.password ?? '',
          );
      return right(credential);
    } catch (e) {
      return left('$e');
    }
  }

  Future<Either<FirebaseException, UserCredential>> signInWithEmail(
      {required AuthEntity auth}) async {
    try {
      final credential = await this.auth.signInWithEmailAndPassword(
            email: auth.email ?? '',
            password: auth.password ?? '',
          );
      return right(credential);
    } on FirebaseAuthException catch (e) {
      return left(e);
    }
  }

  Future<Either<FirebaseException, UserCredential>> signInWithGoogle() async {
    return await _signInWithProvider(() async {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: ["email"]).signIn();
      final googleAuth = await googleUser!.authentication;
      return GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
    });
  }

  Future<Either<FirebaseException, UserCredential>> signInWithFb() async {
    return await _signInWithProvider(() async {
      final loginResult = await FacebookAuth.instance.login();
      return FacebookAuthProvider.credential(
          loginResult.accessToken?.token ?? '');
    });
  }

  Future<Either<FirebaseException, UserCredential>> _signInWithProvider(
    Future<AuthCredential> Function() getCredential,
  ) async {
    try {
      final credential = await getCredential();
      final userCredential = await auth.signInWithCredential(credential);
      await _checkAndAddUser(userCredential.user);
      return right(userCredential);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  Future<void> _checkAndAddUser(User? user) async {
    if (user == null) return;
    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    if (!(await userDoc.get()).exists) {
      userDoc.set({
        'email': user.email,
        'username': user.displayName,
        'urlImage': user.photoURL,
      });
    }
  }

  Future<void> signOut(BuildContext context) async {
    await auth.signOut();
  }
}
