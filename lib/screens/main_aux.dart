import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeiroaplicativo/screens/search_page.dart';
import 'package:primeiroaplicativo/screens/weekprevious_page.dart';
import 'package:primeiroaplicativo/screens/wheaterwarning_page.dart';

import '../db/shared_prefs.dart';
import 'config_page.dart';
import 'favorites_page.dart';
import 'home_page.dart';

class MainAux extends StatefulWidget {
  const MainAux({super.key});

  @override
  State<MainAux> createState() => _MainAuxState();
}

class _MainAuxState extends State<MainAux> {
  SharedPrefs prefs = SharedPrefs();

  int _selectedIndex = 0;
  ThemeMode _themeMode = ThemeMode.light;

  void _onThemeChanged(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: Scaffold(
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          indicatorColor: Colors.transparent,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.search),
              selectedIcon: Icon(Icons.search),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              selectedIcon: Icon(Icons.calendar_month),
              label: 'Week',
            ),
            NavigationDestination(
              icon: Icon(Icons.star_outline),
              selectedIcon: Icon(Icons.star),
              label: 'Favorites',
            ),
            NavigationDestination(
              icon: Icon(Icons.warning_amber_outlined),
              selectedIcon: Icon(Icons.warning),
              label: 'Warning',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'Config',
            ),
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            HomePage(),
            SearchPage(),
            WeekpreviousPage(),
            FavoritesPage(),
            StormWarningPage(),
            ConfigPage(
              isDark: _themeMode == ThemeMode.dark,
              onThemeChanged: _onThemeChanged,
            ),
          ],
        ),
      ),
    );
  }
}
