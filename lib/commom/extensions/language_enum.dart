import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/app_image.dart';

enum LanguageEnum {
  vietnam(0),
  english(1);

  final int id;

  const LanguageEnum(this.id);
}

extension LanguageEnumExt on LanguageEnum {
  int get id => index + 1;

  String title() {
    switch (this) {
      case LanguageEnum.vietnam:
        return "Viet Nam";
      case LanguageEnum.english:
        return "English";
    }
  }

  Widget icon() {
    switch (this) {
      case LanguageEnum.vietnam:
        return Image.asset(
          AppImage.iconVietNam,
          width: 40,
          height: 40,
        );
      case LanguageEnum.english:
        return Image.asset(
          AppImage.iconEngland,
          width: 40,
          height: 40,
        );
    }
  }
}
