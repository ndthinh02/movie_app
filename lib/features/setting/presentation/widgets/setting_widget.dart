import 'package:flutter/material.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({
    super.key,
    this.title,
    this.icon,
  });

  final String? title;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon ?? const SizedBox(),
          const SizedBox(
            width: 20,
          ),
          Text(
            title ?? '',
            style: text.headlineSmall?.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
