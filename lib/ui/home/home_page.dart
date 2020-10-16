import 'dart:math';

import 'package:coffee_life_manager/ui/page/list_page/bean_list/bean_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_coffee_list/cafe_coffee_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_list/cafe_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/house_coffee_list/house_coffee_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

import '../../theme_manager.dart';

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
            icon: const Icon(Icons.settings),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          // #### begin 家(豆・コーヒー)
          _TitleImage(
            image: const AssetImage('assets/coffee.jpg'),
            text: 'House',
            children: [
              FlatButton(
                child: const Text(
                  'コーヒー豆',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, BeanListPage.routeName);
                },
              ),
              FlatButton(
                child: const Text(
                  'コーヒー',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, HouseCoffeeListPage.routeName);
                },
              ),
            ],
          ),

          // #### begin カフェ (カフェ・コーヒー)
          _TitleImage(
            image: const AssetImage('assets/coffee-shop.jpg'),
            text: 'Cafe',
            children: [
              FlatButton(
                child: const Text(
                  'カフェ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, CafeListPage.routeName);
                },
              ),
              FlatButton(
                child: const Text(
                  'コーヒー',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, CafeCoffeeListPage.routeName);
                },
              ),
            ],
          ),
          // #### end カフェ (カフェ・コーヒー)
        ],
      ),
    );
  }
}

class _TitleImage extends StatelessWidget {
  const _TitleImage({
    @required this.image,
    @required this.text,
    @required this.children,
  });
  final AssetImage image;
  final String text;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    final widget = Container(
      margin: const EdgeInsets.only(
        left: 5,
        right: 5,
        top: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.4),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 60,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white70,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final orientation = MediaQuery.of(context).orientation;
    return SizedBox(
      height: (max(
                MediaQuery.of(context).size.height,
                MediaQuery.of(context).size.width,
              ) -
              kToolbarHeight -
              20 * ((orientation == Orientation.portrait) ? 1 : -1)) /
          2,
      child: widget,
    );
  }
}

class _AssetIconButtonWithText extends StatelessWidget {
  const _AssetIconButtonWithText({
    @required this.imageUri,
    @required this.text,
    @required this.onTap,
  });
  final String imageUri;
  final String text;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            height: 30,
            child: Image.asset(
              imageUri,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
