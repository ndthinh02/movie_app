import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:movie_app/commom/extensions/error_extension.dart';
import 'package:movie_app/commom/widgets/button.dart';
import 'package:movie_app/commom/widgets/text_filed.dart';
import 'package:movie_app/config/colors/app_colors.dart';
import 'package:movie_app/features/auth/domain/entity/auth_entity.dart';

import '../../../../../route/route_name.dart';
import '../../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCon = TextEditingController();

  final TextEditingController _passwordCon = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  bool isLoadingEmail = false;
  bool isLoadingGg = false;
  bool isLoadingFb = false;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSignupFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  showCloseIcon: true,
                  content: Text(
                    state.errorEmail.toErrorMessage(text) ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontFamily: "InriaSans",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }
            if (state is AuthSignupSuccess) {
              if (state.isNavigateHomePage ?? true) {
                _navigateHomeScreen();
              }
            }
            if (state is AuthSignInGoogleSuccess) {
              _navigateHomeScreen();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _keyForm,
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
                    isShowPass: false,
                    height: 90,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return text.do_not_empty;
                      }
                    },
                    labelText: "Email",
                    controller: _emailCon,
                    prefixIcon: Icons.email_outlined,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AppTextFiled(
                    isShowPass: true,
                    height: 90,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return text.do_not_empty;
                      }
                    },
                    labelText: text.password,
                    controller: _passwordCon,
                    prefixIcon: Icons.lock,
                    suffixIcon: Icons.remove_red_eye_outlined,
                    suffixIconTapped: Icons.remove_red_eye_sharp,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppButton(
                    isLoading: isLoadingEmail,
                    onTap: () {
                      setState(() {
                        isLoadingEmail = true;
                      });
                      if (_keyForm.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              SignInWithEmail(
                                authEntity: AuthEntity(
                                  email: _emailCon.text,
                                  password: _passwordCon.text,
                                ),
                              ),
                            );
                      }
                    },
                    backGrColor: AppColors.colorGreen,
                    title: text.login,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppButton(
                    isLoading: isLoadingGg,
                    onTap: () {
                      setState(() {
                        isLoadingGg = true;
                      });
                      context.read<AuthBloc>().add(SignInWithGoogle());
                    },
                    backGrColor: AppColors.colorGreen,
                    title: text.login_with_google,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppButton(
                    isLoading: isLoadingFb,
                    onTap: () {
                      setState(() {
                        isLoadingFb = true;
                      });
                      context.read<AuthBloc>().add(SignInWithFb());
                    },
                    backGrColor: AppColors.colorGreen,
                    title: text.login_with_fb,
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
          ),
        ),
      ),
    );
  }

  _navigateSignupScreen() {
    Navigator.of(context).pushNamed(RouteName.signup);
  }

  _navigateHomeScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteName.home,
      (Route<dynamic> route) => false,
    );
  }
}
