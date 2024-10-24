import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/di.dart';
import 'package:movie_app/features/favorite/presentation/favorite.dart';
import 'package:movie_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie_app/features/home/presentation/page/home_screen.dart';
import 'package:movie_app/features/landing/presentation/landing_page.dart';
import 'package:movie_app/features/login/presentation/page/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:movie_app/features/search/presentation/search_screen.dart';
import 'package:movie_app/features/setting/presentation/setting_screen.dart';
import 'config/colors/app_colors.dart';
import 'config/themes/app_themes.dart';
import 'l10n/l10n.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (context) => getIt<HomeBloc>(),
          ),
        ],
        child: MaterialApp(
          supportedLocales: L10n.all,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: const Locale('vi'),
          theme: theme(),
          debugShowCheckedModeBanner: false,
          home: const LandingPage(),
        ));
  }
}
