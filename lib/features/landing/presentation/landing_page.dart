import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:movie_app/commom/widgets/button.dart';
import 'package:movie_app/config/colors/app_colors.dart';
import 'package:movie_app/core/app_image.dart';

import '../../../../route/route_name.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            width: double.infinity,
            height: double.infinity,
            AppImage.imgBanner,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 297,
              decoration: BoxDecoration(
                color: AppColors.black.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      text.watchMovie,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      text.explore_a_vast,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    AppButton(
                      title: text.login,
                      colorTitle: AppColors.black,
                      backGrColor: AppColors.colorGreen,
                      onTap: () {
                        _navigateLoginScreen(context);
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    AppButton(
                      title: text.signup,
                      colorTitle: AppColors.colorGreenText,
                      backGrColor: Colors.transparent,
                      colorBorder: AppColors.colorGreen,
                      onTap: () {
                        _navigateSignupScreen(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _navigateSignupScreen(BuildContext context) {
    Navigator.pushNamed(context, RouteName.signup);
  }

  _navigateLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, RouteName.login);
  }
}
