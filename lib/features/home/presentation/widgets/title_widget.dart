import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../../route/route_name.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    this.title,
    this.fontSize,
    this.fontSizeSub,
    this.type,
    this.isDetail,
    this.name,
  });

  final String? title;
  final double? fontSize;
  final double? fontSizeSub;
  final String? type;
  final String? name;
  final bool? isDetail;

  void _navigateMoreScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      RouteName.more,
      arguments: {
        'type': type,
        'name': name,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final themeText = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? '',
          style: themeText.headlineMedium,
        ),
        InkWell(
          onTap: () => isDetail ?? false ? null : _navigateMoreScreen(context),
          child: Text(
            text.view_all,
            style: themeText.headlineSmall,
          ),
        ),
      ],
    );
  }
}
