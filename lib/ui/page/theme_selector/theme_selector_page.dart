import 'package:coffee_life_manager/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class ThemeSelectorPage extends StatelessWidget {
  const ThemeSelectorPage();
  static const routeName = '/themeSelectorPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('テーマを選択'),
      ),
      body: const ThemeSelectorWidget(),
    );
  }
}

class ThemeSelectorWidget extends StatelessWidget {
  const ThemeSelectorWidget();
  @override
  Widget build(BuildContext context) {
    const size = 80.0;
    return SizedBox(
      height: size * ThemeManager.themes.length / 2,
      width: size * ThemeManager.themes.length,
      child: GridView.count(
        crossAxisCount: 4,
        children: [
          for (var i = 0; i < ThemeManager.themes.length; i++)
            InkWell(
              onTap: () => context.read(themeManager).setTheme(i),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                    Container(
                      color: ThemeManager.themes[i].accentColor,
                    ),
                    Container(
                      color: ThemeManager.themes[i].primaryColor,
                    ),
                    Container(
                      color: ThemeManager.themes[i].cardColor,
                    ),
                    Container(
                      color: ThemeManager.themes[i].backgroundColor,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
