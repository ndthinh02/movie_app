import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/config/themes/app_themes.dart';

import '../../domain/entity/auth_entity.dart';
import '../../domain/usecase/auth_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthUseCase _useCase;

  AuthBloc(this._useCase) : super(AuthInitial()) {
    on<SignupWithEmail>(
      (event, emit) => _onSignupWithEmail(event, emit),
    );
    on<SignInWithEmail>(
      (event, emit) => _onSignInWithEmail(event, emit),
    );
    on<SignInWithGoogle>(
      (event, emit) => _onSignInWithGoogle(event, emit),
    );
    on<SignInWithFb>(
      (event, emit) => _onSignInWithFb(event, emit),
    );
  }

  void _addUser(AuthEntity? auth) {
    final users = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    users.set(
      auth?.toMap() ?? {},
    );
  }



  _onSignupWithEmail(SignupWithEmail event, Emitter emit) async {
    emit(AuthSignupLoading());
    await Future.delayed(const Duration(seconds: 2));
    final result = await _useCase
        .signupWithEmail(
          authEntity: event.authEntity ?? AuthEntity(),
        )
        .whenComplete(
          () => _addUser(event.authEntity),
        );

    result.fold((err) {
      emit(
        AuthSignupFailed(
          errorEmail: err,
        ),
      );

      return left(err);
    }, (data) {
      emit(
        AuthSignupSuccess(
          isNavigateHomePage: false,
        ),
      );
      logger.d(data);
      return right(data);
    });
  }

  _onSignInWithEmail(SignInWithEmail event, Emitter emit) async {
    emit(
      AuthSignupLoading(),
    );
    await Future.delayed(const Duration(seconds: 2));
    final result = await _useCase.signInWithEmail(
      authEntity: event.authEntity ?? AuthEntity(),
    );
    result.fold((err) {
      emit(
        AuthSignupFailed(
          errorEmail: err.toString(),
        ),
      );
      logger.d(err);
      return left(err);
    }, (data) {
      emit(
        AuthSignupSuccess(
          isNavigateHomePage: true,
        ),
      );
      logger.d(data);
      return right(data);
    });
  }

  _onSignInWithGoogle(SignInWithGoogle event, Emitter emit) async {
    emit(
      AuthSignupLoading(),
    );
    await Future.delayed(const Duration(seconds: 2));
    final result =
        await _useCase.signInWithGoogle();

    result.fold((err) {
      emit(
        AuthSignupFailed(
          errorEmail: err.toString(),
        ),
      );
      logger.d(err);
      return left(err);
    }, (data) {
      emit(
        AuthSignInGoogleSuccess(),
      );
      logger.d(data);
      return right(data);
    });
  }

  _onSignInWithFb(SignInWithFb event, Emitter emit) async {
    emit(
      AuthSignupLoading(),
    );
    await Future.delayed(const Duration(seconds: 2));
    final result =
        await _useCase.signInWithFb();

    result.fold((err) {
      emit(
        AuthSignupFailed(
          errorEmail: err.toString(),
        ),
      );
      logger.d(err);
      return left(err);
    }, (data) {
      emit(
        AuthSignInGoogleSuccess(),
      );
      logger.d(data);
      return right(data);
    });
  }
}
