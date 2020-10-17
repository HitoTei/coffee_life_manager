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
    const size = 50.0;
    return SizedBox(
      height: size * 4 * ThemeManager.themes.length,
      width: size * 5,
      child: GridView.count(
        crossAxisCount: 4,
        children: [
          for (var i = 0; i < ThemeManager.themes.length; i++)
            InkWell(
              onTap: () => context.read(themeManager).setTheme(i),
              child: Container(
                margin: const EdgeInsets.all(size / 5),
                height: size,
                width: size,
                decoration: BoxDecoration(
                  color: ThemeManager.themes[i].primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
