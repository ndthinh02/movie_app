import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:movie_app/commom/widgets/button.dart';
import 'package:movie_app/commom/widgets/text_filed.dart';
import 'package:movie_app/config/colors/app_colors.dart';
import 'package:movie_app/features/login/presentation/page/login_screen.dart';
import 'package:movie_app/features/signup/presentation/page/signup_screen.dart';
import 'package:movie_app/main.dart';

import '../../../../my_home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _userCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 200,
            ),
            Text(
              text.login,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            AppTextFiled(
              labelText: "Email",
              controller: _emailCon,
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(
              height: 30,
            ),
            AppTextFiled(
              labelText: text.password,
              controller: _passwordCon,
              prefixIcon: Icons.lock,
              suffixIcon: Icons.remove_red_eye_outlined,
              suffixIconTapped: Icons.remove_red_eye_sharp,
            ),
            const SizedBox(
              height: 60,
            ),
            AppButton(
              onTap: () {
                _navigateHomeScreen();
              },
              backGrColor: AppColors.colorGreen,
              title: text.login,
            ),
            const SizedBox(
              height: 30,
            ),
            RichText(
              text: TextSpan(
                text: text.register_account,
                style: const TextStyle(
                  fontFamily: 'InriaSans',
                ),
                children: [
                  TextSpan(
                    text: text.signup,
                    style: TextStyle(
                      color: AppColors.colorBlueText,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _navigateSignupScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _navigateSignupScreen() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SignUpScreen(),
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ),
    );
  }

  _navigateHomeScreen() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const MyHomePage(),
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ),
    );
  }
}
