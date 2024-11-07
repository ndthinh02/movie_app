import 'package:flutter/material.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({
    super.key,
    this.icon,
    this.title,
    required this.onPress,
    this.selectedIndex,
    this.index,
    this.widgetVisibility,
  });

  final String? title;
  final Widget? icon;
  final Function onPress;
  final int? selectedIndex;
  final int? index;
  final bool? widgetVisibility;

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;
    return InkWell(
      onTap: () => onPress(),
      child: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Row(
          children: [
            icon ?? const SizedBox(),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                title ?? '',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontSize: 18),
              ),
            ),
            selectedIndex == index
                ? Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        )),
                    padding: const EdgeInsets.all(8),
                    child: const CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 10,
                    ),
                  )
                : Text('')
          ],
        ),
      ),
    );
  }
}
