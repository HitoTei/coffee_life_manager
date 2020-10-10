import 'package:coffee_life_manager/theme_manager.dart';
import 'package:coffee_life_manager/ui/page/list_page/bean_list/bean_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_coffee_list/cafe_coffee_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_list/cafe_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/house_coffee_list/house_coffee_list_page.dart';
import 'package:coffee_life_manager/ui/page/theme_selector/theme_selector_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';



class HomePage extends StatelessWidget {
  const HomePage();
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('たいとる！'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              final res = await showMenu<ThemeData>(
                context: context,
                position: RelativeRect.fromSize(Rect.zero, Size(100, 100)),
                items: [
                  for (final theme in ThemeManager.themes)
                    PopupMenuItem(
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.all(
                          10,
                        ),
                        child: GridView.count(
                          crossAxisCount: 2,
                          children: [
                            Container(
                              color: theme.accentColor,
                            ),
                            Container(
                              color: theme.primaryColor,
                            ),
                            Container(
                              color: theme.cardColor,
                            ),
                            Container(
                              color: theme.backgroundColor,
                            ),
                          ],
                        ),
                      ),
                      value: theme,
                    ),
                ],
              );
              if (res != null) {
                context.read(appTheme).state = res;
              }
            },
          ),
        ],
      ),
      body: const HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('コーヒー豆'),
          onTap: () => Navigator.pushNamed(
            context,
            BeanListPage.routeName,
          ),
        ),
        ListTile(
          title: const Text('カフェ'),
          onTap: () => Navigator.pushNamed(
            context,
            CafeListPage.routeName,
          ),
        ),
        ListTile(
          title: const Text('家コーヒー'),
          onTap: () => Navigator.pushNamed(
            context,
            HouseCoffeeListPage.routeName,
          ),
        ),
        ListTile(
          title: const Text('カフェコーヒー'),
          onTap: () => Navigator.pushNamed(
            context,
            CafeCoffeeListPage.routeName,
          ),
        ),
        ListTile(
          title: const Text('テーマ変更'),
          onTap: () => Navigator.pushNamed(
            context,
            ThemeSelectorPage.routeName,
          ),
        ),
      ],
    );
  }
}
