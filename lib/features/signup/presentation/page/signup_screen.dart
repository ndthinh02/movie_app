import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:movie_app/commom/widgets/button.dart';
import 'package:movie_app/commom/widgets/text_filed.dart';
import 'package:movie_app/config/colors/app_colors.dart';
import 'package:movie_app/features/login/presentation/page/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _userCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 200,
              ),
              Text(
                text.signup,
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
                labelText: text.username,
                controller: _userCon,
                prefixIcon: Icons.person,
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
                  _navigateLoginScreen();
                },
                backGrColor: AppColors.colorGreen,
                title: text.create_account,
              ),
              const SizedBox(
                height: 30,
              ),
              RichText(
                text: TextSpan(
                  text: text.have_account,
                  style: const TextStyle(
                    fontFamily: 'InriaSans',
                  ),
                  children: [
                    TextSpan(
                      text: text.login,
                      style: TextStyle(
                        color: AppColors.colorBlueText,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _navigateLoginScreen();
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _navigateLoginScreen() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const LoginScreen(),
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ),
    );
  }
}
