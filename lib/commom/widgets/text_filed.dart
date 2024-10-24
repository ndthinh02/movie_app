import 'package:flutter/material.dart';

import '../../config/colors/app_colors.dart';

class AppTextFiled extends StatefulWidget {
  const AppTextFiled({
    super.key,
    this.height,
    this.radius,
    this.labelText,
    this.colorBorderSide,
    required this.controller,
    this.colorTextEnabledBorder,
    this.suffixIcon,
    this.prefixIcon,
    this.colorEnabledBorder,
    this.suffixIconTapped,
  });

  final double? height;
  final double? radius;
  final String? labelText;
  final Color? colorBorderSide;
  final TextEditingController controller;
  final Color? colorTextEnabledBorder;
  final IconData? suffixIcon;
  final IconData? suffixIconTapped;
  final IconData? prefixIcon;
  final Color? colorEnabledBorder;

  @override
  State<AppTextFiled> createState() => _AppTextFiledState();
}

class _AppTextFiledState extends State<AppTextFiled> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    final color =
        widget.controller.text == "" ? Colors.white : AppColors.colorGreen;
    return SizedBox(
      height: widget.height ?? 54,
      child: TextField(
        obscureText: obscureText,
        controller: widget.controller,
        cursorColor: AppColors.colorGreen,
        style: TextStyle(
          color: AppColors.colorGreenText,
        ),
        onChanged: (v) {
          setState(() {
            widget.controller.text = v;
          });
        },
        decoration: InputDecoration(
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            child: obscureText
                ? Icon(
                    widget.suffixIcon,
                    color: Colors.white,
                  )
                : Icon(
                    widget.suffixIconTapped,
                    color: Colors.white,
                  ),
          ),
          prefixIcon: Icon(
            widget.prefixIcon,
            color: color,
          ),
          labelText: widget.labelText ?? '',
          labelStyle: TextStyle(
            color: color,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              widget.radius ?? 10,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: color,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
