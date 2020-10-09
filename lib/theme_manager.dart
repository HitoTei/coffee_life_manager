import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appTheme = StateProvider.autoDispose((_) => ThemeData.light());
final themeManager = Provider.autoDispose((ref) => ThemeManager(ref.read));

class ThemeManager {
  ThemeManager(this.read) {
    _pref.then((value) {
      final index = value.getInt(_key);
      if (index != null) {
        read(appTheme).state = themes[index];
      }
    });
  }

  final Reader read;

  final _pref = SharedPreferences.getInstance();
  static const _key = 'CoffeeLifeManagerThemeData';
  static final themes = <ThemeData>[
    ThemeData.dark(),
    ThemeData.light(),
    ThemeData(
      primarySwatch: Colors.brown,
      primaryColor: const Color(0xFF795548),
      accentColor: const Color(0xFFbc2a11),
      canvasColor: const Color(0xFFfafafa),
      fontFamily: 'Merriweather',
    ),
    ThemeData(
      primarySwatch: Colors.brown,
      primaryColor: const Color(0xFF795548),
      accentColor: Colors.deepOrange,
      canvasColor: const Color(0xFFdcccc5),
      buttonColor: Colors.white70,
    ),
    ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blueGrey,
      primaryColor: const Color(0xFF212121),
      accentColor: Colors.redAccent,
      canvasColor: Colors.brown[800],
      fontFamily: 'Merriweather',
    ),
  ];

  void setTheme(ThemeData theme) {
    _pref.then((value) {
      read(appTheme).state = theme;
      value.setInt(_key, themes.indexOf(theme));
    });
  }
}
