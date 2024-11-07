import 'package:flutter/material.dart';
import 'package:movie_app/features/detail/presentation/page/detail_screen.dart';
import 'package:movie_app/features/landing/presentation/landing_page.dart';
import 'package:movie_app/features/search/presentation/search_screen.dart';
import 'package:movie_app/features/setting/presentation/pages/account_screen.dart';
import 'package:movie_app/features/setting/presentation/pages/language_screen.dart';
import 'package:movie_app/features/setting/presentation/pages/watch_history_screen.dart';
import 'package:movie_app/features/splash/presentation/page/splash_screen.dart';
import 'package:movie_app/my_home_page.dart';

import '../../../../route/route_name.dart';
import '../features/auth/presentation/pages/login/login_screen.dart';
import '../features/auth/presentation/pages/signup/signup_screen.dart';
import '../features/more/presentation/page/more_screen.dart';

class AppRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // final argsAccountScreen = settings.arguments as Map<String, dynamic>;
    switch (settings.name) {
      case RouteName.login:
        return _buildPageRoute(
          const LoginScreen(),
          settings,
        );
      case RouteName.signup:
        return _buildPageRoute(
          const SignUpScreen(),
          settings,
        );
      case RouteName.landing:
        return _buildPageRoute(
          const LandingPage(),
          settings,
        );
      case RouteName.home:
        return _buildPageRoute(
          const MyHomePage(),
          settings,
        );
      case RouteName.more:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildPageRoute(
          MoreScreen(
            type: args['type'],
            name: args['name'],
          ),
          settings,
        );
      case RouteName.detail:
        final args = settings.arguments as String? ?? '';
        return _buildPageRoute(
          DetailScreen(slugMovie: args),
          settings,
        );
      case RouteName.search:
        return _buildPageRoute(
          const SearchScreen(),
          settings,
        );

      case RouteName.splash:
        return _buildPageRoute(
          const SplashScreen(),
          settings,
        );
      case RouteName.watchHistory:
        return _buildPageRoute(
          const WatchHistoryScreen(),
          settings,
        );
      case RouteName.language:
        return _buildPageRoute(
          const LanguageScreen(),
          settings,
        );
      case RouteName.account:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildPageRoute(
          AccountScreen(
            urlImage: args['urlImage'],
            username: args['username'],
          ),
          settings,
        );

      default:
        return null;
    }
  }

  static PageRouteBuilder _buildPageRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
