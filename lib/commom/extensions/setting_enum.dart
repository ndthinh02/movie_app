import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

enum SettingEnum {
  account(0),
  darkMode(1),
  watchHistory(2),
  notification(3),
  language(4),
  signOut(5);

  final int id;

  const SettingEnum(this.id);
}

extension SettingEnumExt on SettingEnum {
  int get id => index + 1;

  String title(BuildContext context, bool darkMode) {
    final text = AppLocalizations.of(context)!;
    switch (this) {
      case SettingEnum.account:
        return text.account;
      case SettingEnum.darkMode:
        return !darkMode ? text.dark_mode : text.light_mode;
      case SettingEnum.watchHistory:
        return text.watch_history;
      case SettingEnum.signOut:
        return text.sign_out;
      case SettingEnum.notification:
        return text.notification;
      case SettingEnum.language:
        return text.language;
    }
  }

  Widget icon(BuildContext context) {
    switch (this) {
      case SettingEnum.account:
        return const Icon(
          Icons.person,
        );
      case SettingEnum.darkMode:
        return const Icon(
          Icons.dark_mode,
        );
      case SettingEnum.watchHistory:
        return const Icon(
          Icons.history,
        );
      case SettingEnum.signOut:
        return const Icon(
          Icons.logout,
        );
      case SettingEnum.notification:
        return const Icon(
          Icons.notifications_none_outlined,
        );
      case SettingEnum.language:
        return const Icon(
          Icons.language,
        );
    }
  }
}
