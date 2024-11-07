part of 'setting_bloc.dart';

@immutable
sealed class SettingState {}

final class SettingInitial extends SettingState {}

class UserLoading extends SettingState {}

class UserLoadSuccess extends SettingState {
  final UserEntity? userEntity;

  UserLoadSuccess({
    this.userEntity,
  });
}

class UserLoadFailed extends SettingState {}

class LoadAvatarState extends SettingState {}

class UpdateAvatarState extends SettingState {
  final File? file;
  final String? urlImage;
  final bool? isPickImage;

  UpdateAvatarState({
    this.file,
    this.isPickImage,
    this.urlImage,
  });
}

class UpdateUserSuccess extends SettingState {}
