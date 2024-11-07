import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/setting/presentation/bloc/setting_bloc.dart';

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
    this.isLoading,
  });

  final double? height;
  final double? width;
  final double? radius;
  final VoidCallback onTap;
  final String? title;
  final Color? backGrColor;
  final Color? colorTitle;
  final Color? colorBorder;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSignupLoading) {
          return isLoading ?? true ? _loading(context) : _initial(context);
        }

        return _initial(context);
      },
    );
  }

  _loading(BuildContext context) {
    return Container(
      height: height ?? 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 12),
        color: backGrColor,
      ),
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 12),
          ),
          backgroundColor: backGrColor,
          minimumSize: Size(
            width ?? MediaQuery.of(context).size.width,
            height ?? 60,
          ),
        ),
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }

  _initial(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 12),
        ),
        backgroundColor: backGrColor,
        minimumSize: Size(
          width ?? MediaQuery.of(context).size.width,
          height ?? 60,
        ),
      ),
      child: Center(
        child: Text(
          title ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: colorTitle ?? Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}


class AppButtonAccount extends StatelessWidget {
  const AppButtonAccount({
    super.key,
    this.height,
    this.width,
    required this.onTap,
    this.title,
    this.backGrColor,
    this.colorTitle,
    this.colorBorder,
    this.radius,
    this.isLoading,
  });

  final double? height;
  final double? width;
  final double? radius;
  final VoidCallback onTap;
  final String? title;
  final Color? backGrColor;
  final Color? colorTitle;
  final Color? colorBorder;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        if (state is LoadAvatarState) {
          return isLoading ?? true ? _loading(context) : _initial(context);
        }

        return _initial(context);
      },
    );
  }

  _loading(BuildContext context) {
    return Container(
      height: height ?? 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 12),
        color: backGrColor,
      ),
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 12),
          ),
          backgroundColor: backGrColor,
          minimumSize: Size(
            width ?? MediaQuery.of(context).size.width,
            height ?? 60,
          ),
        ),
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }

  _initial(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 12),
        ),
        backgroundColor: backGrColor,
        minimumSize: Size(
          width ?? MediaQuery.of(context).size.width,
          height ?? 60,
        ),
      ),
      child: Center(
        child: Text(
          title ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: colorTitle ?? Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

