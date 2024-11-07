part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignupWithEmail extends AuthEvent {
  final AuthEntity? authEntity;
  final BuildContext? context;

  SignupWithEmail({
    this.authEntity,
    this.context,
  });
}

class SignInWithEmail extends AuthEvent {
  final AuthEntity? authEntity;
  final bool? isLoading;

  SignInWithEmail({
    this.authEntity,
    this.isLoading,
  });
}

class SignInWithGoogle extends AuthEvent {
  final bool? isLoading;

  SignInWithGoogle({
    this.isLoading,
  });
}

class SignInWithFb extends AuthEvent {
  SignInWithFb();
}
