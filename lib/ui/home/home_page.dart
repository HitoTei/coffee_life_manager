import 'package:coffee_life_manager/ui/page/list_page/bean_list/bean_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_coffee_list/cafe_coffee_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_list/cafe_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/house_coffee_list/house_coffee_list_page.dart';
import 'package:coffee_life_manager/ui/page/theme_selector/theme_selector_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage();
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('たいとる！'),
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
