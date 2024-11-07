part of 'setting_bloc.dart';

@immutable
sealed class SettingEvent {}

class GetUser extends SettingEvent {}

class UpdateAvatar extends SettingEvent {
  final String? username;

  UpdateAvatar({
    this.username,
  });
}

class PickImage extends SettingEvent {}
