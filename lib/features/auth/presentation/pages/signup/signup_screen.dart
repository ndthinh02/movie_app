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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _userCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailCon.clear();
    _userCon.clear();
    _passwordCon.clear();
    _emailCon.dispose();
    _userCon.dispose();
    _passwordCon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      text.register_successfully,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontFamily: "InriaSans",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }
            },
            child: Form(
              key: _formKey,
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
                  AppTextFiled(
                    height: 90,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return text.do_not_empty;
                      }
                    },
                    labelText: text.username,
                    controller: _userCon,
                    prefixIcon: Icons.person,
                  ),
                  AppTextFiled(
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
                    height: 40,
                  ),
                  AppButton(
                    isLoading: true,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              SignupWithEmail(
                                authEntity: AuthEntity(
                                  email: _emailCon.text,
                                  password: _passwordCon.text,
                                  username: _userCon.text,
                                ),
                              ),
                            );
                      }
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
        ),
      ),
    );
  }

  _navigateLoginScreen() {
    Navigator.of(context).pushNamed(RouteName.login);
  }
}
