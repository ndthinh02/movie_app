part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthSignupLoading extends AuthState {
  final bool? isGoogleLoading;
  final bool? isEmailLoading;
  final bool? isFbLoading;

  AuthSignupLoading({
    this.isGoogleLoading,
    this.isEmailLoading,
    this.isFbLoading,
  });
}

class AuthSignupSuccess extends AuthState {
  final bool? isNavigateHomePage;

  AuthSignupSuccess({
    this.isNavigateHomePage,
  });
}

class AuthSignupFailed extends AuthState {
  final String? errorEmail;

  // final String? errorPassword;

  AuthSignupFailed({
    this.errorEmail,
    // this.errorPassword,
  });
}

class AuthSignInGoogleSuccess extends AuthState {}

class AuthSignInFbSuccess extends AuthState {}
