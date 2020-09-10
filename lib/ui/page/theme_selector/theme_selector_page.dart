import 'package:coffee_life_manager/theme_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeSelectorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('テーマを選択'),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        children: [
          for (var theme in ThemeManager.themes)
            Container(
              color: theme.primaryColor,
              child: ListTile(
                leading: Icon(
                  Icons.adjust,
                  color: theme.accentColor,
                ),
                onTap: () {
                  ThemeManager().setTheme(theme);
                },
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.close),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(),
          StadiumBorder(
            side: BorderSide(),
          ),
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
