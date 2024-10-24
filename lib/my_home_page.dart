import 'package:flutter/material.dart';

import 'config/colors/app_colors.dart';
import 'features/favorite/presentation/favorite.dart';
import 'features/home/presentation/page/home_screen.dart';
import 'features/search/presentation/search_screen.dart';
import 'features/setting/presentation/setting_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    for (int i = 0; i < _pages.length; i++) {
      setState(() {
        _selectedIndex = i;
      });
    }
  }

  final List<Widget> _pages = [
    HomeScreen(),
    SearchScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
            color: AppColors.colorPrimary,
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
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
              child: Icon(
                Icons.home_outlined,
                color:
                    _selectedIndex == 0 ? AppColors.colorGreen : Colors.white,
                size: 28,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              child: Icon(
                Icons.search,
                color:
                    _selectedIndex == 1 ? AppColors.colorGreen : Colors.white,
                size: 28,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
              child: Icon(
                Icons.favorite_border,
                color:
                    _selectedIndex == 2 ? AppColors.colorGreen : Colors.white,
                size: 28,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
              },
              child: Icon(
                Icons.settings,
                color:
                    _selectedIndex == 3 ? AppColors.colorGreen : Colors.white,
                size: 28,
              ),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
