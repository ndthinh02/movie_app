import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:movie_app/config/themes/app_themes.dart';
import 'package:movie_app/di.dart';
import 'package:movie_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie_app/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie_app/route/route_generator.dart';

import '../../../../route/route_name.dart';
import 'commom/bloc/language/language_bloc.dart';
import 'commom/bloc/theme/app_theme_bloc.dart';
import 'features/detail/presentation/bloc/detail_bloc.dart';
import 'features/more/presentation/bloc/more_bloc.dart';
import 'features/search/presentation/bloc/search_bloc.dart';
import 'features/setting/presentation/bloc/setting_bloc.dart';
import 'firebase_options.dart';
import 'l10n/l10n.dart';

Future<void> main() async {
  setUp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: DefaultFirebaseOptions.name,
    options: DefaultFirebaseOptions.firebaseOptions,
  );
  await FlutterDownloader.initialize(
    debug: true,
    ignoreSsl: true,
  );

  // await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.debug,
  //   appleProvider: AppleProvider.debug,
  // );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<HomeBloc>()),
        BlocProvider(create: (context) => getIt<DetailBloc>()),
        BlocProvider(create: (context) => getIt<SearchBloc>()),
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<FavoriteBloc>()),
        BlocProvider(create: (context) => getIt<SettingBloc>()),
        BlocProvider(create: (context) => getIt<MoreBloc>()),
        BlocProvider(
          create: (context) => LanguageBloc()
            ..add(
              LoadLanguageEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => AppThemeBloc()
            ..add(
              LoadThemeEvent(),
            ),
        ),
      ],
      child: BlocBuilder<AppThemeBloc, AppThemeState>(
        builder: (context, stateTheme) {
          return BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              return MaterialApp(
                supportedLocales: L10n.all,
                onGenerateRoute: AppRoute.onGenerateRoute,
                initialRoute: RouteName.splash,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                locale: state.locale,
                theme:
                    stateTheme.isDarkTheme == true ? darkTheme() : lightTheme(),
                debugShowCheckedModeBanner: false,
              );
            },
          );
        },
      ),
    );
  }
}
