import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ValueNotifier<ThemeData> {
  factory ThemeManager() {
    return _cache;
  }

  ThemeManager._internal() : super(themes[0]) {
    _getValue().then((data) {
      value = data;
      notifyListeners();
    });
  }

  static final _cache = ThemeManager._internal();
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
    if (value == theme) return;
    int index;
    for (var i = 0; i < themes.length; i++) {
      if (themes[i] == theme) {
        index = i;
        break;
      }
    }
    if (index == null) return;
    _savePosition(index);

    value = theme;
    notifyListeners();
  }

  Future<ThemeData> _getValue() async {
    final pref = await _pref;
    final position = pref.getInt(_key);
    if (position == null) return null;
    return themes[position];
  }

  Future<void> _savePosition(int val) async {
    final pref = await _pref;
    await pref.setInt(_key, val);
  }
}
