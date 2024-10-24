import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.height,
    this.width,
    required this.onTap,
    this.title,
    this.backGrColor,
    this.colorTitle,
    this.colorBorder,
    this.radius,
  });

  final double? height;
  final double? width;
  final double? radius;
  final VoidCallback onTap;
  final String? title;
  final Color? backGrColor;
  final Color? colorTitle;
  final Color? colorBorder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 58,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: backGrColor,
          borderRadius: BorderRadius.circular(radius ?? 8),
          border: Border.all(
            width: 1,
            color: colorBorder ?? Colors.transparent,
          ),
        ),
        child: Center(
          child: Text(
            title ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: colorTitle,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
