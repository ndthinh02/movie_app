import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/commom/event_bus/update_favorite.dart';
import 'package:movie_app/commom/event_bus/update_user.dart';
import 'package:movie_app/config/colors/app_colors.dart';
import 'package:movie_app/di.dart';

import 'commom/bloc/theme/app_theme_bloc.dart';
import 'features/favorite/presentation/bloc/favorite_bloc.dart';
import 'features/favorite/presentation/pages/favorite_screen.dart';
import 'features/home/presentation/page/home_screen.dart';
import 'features/setting/presentation/bloc/setting_bloc.dart';
import 'features/setting/presentation/pages/setting_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final StreamSubscription _updateUserSub;
  late final StreamSubscription _updateFavoriteSub;
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const FavoriteScreen(),
    const SettingScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _updateUserSub = getIt<EventBus>().on<UpdateUser>().listen(
          (_) => context.read<SettingBloc>().add(GetUser()),
        );
    _updateFavoriteSub = getIt<EventBus>().on<UpdateFavorite>().listen(
          (_) => context.read<FavoriteBloc>().add(GetListFavorite()),
        );
  }

  @override
  void dispose() {
    _updateUserSub.cancel();
    _updateFavoriteSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) => SystemNavigator.pop(),
      child: Scaffold(
        bottomNavigationBar: _buildBottomNavigationBar(),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    final icons = [
      Icons.home_outlined,
      Icons.favorite_border,
      Icons.settings,
    ];
    return BlocBuilder<AppThemeBloc, AppThemeState>(
      builder: (context, state) {
        return Container(
          height: 80,
          decoration: BoxDecoration(
            color: state.isDarkTheme!
                ? AppColors.colorPrimary
                : AppColors.primaryBackgroundHome,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              icons.length,
              (index) => GestureDetector(
                onTap: () => setState(() => _selectedIndex = index),
                child: Icon(
                  icons[index],
                  color: _getIconColor(
                    index,
                    state.isDarkTheme!,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getIconColor(int index, bool isDarkTheme) {
    return _selectedIndex == index
        ? AppColors.colorGreen
        : isDarkTheme
            ? Colors.white
            : Colors.black;
  }
}