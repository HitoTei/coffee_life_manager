import 'package:coffee_life_manager/ui/page/list_page/bean_list/bean_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_coffee_list/cafe_coffee_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_list/cafe_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/house_coffee_list/house_coffee_list_page.dart';
import 'package:coffee_life_manager/ui/page/theme_selector/theme_selector_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _fontFamily = 'Charm'; // or Charm

class HomePage extends StatelessWidget {
  const HomePage();
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CoLiSu',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontFamily: _fontFamily,
          ),
        ),
        actions: [
          IconButton(
            tooltip: '設定',
            icon: const Icon(Icons.settings),
            onPressed: () async {
              await showModalBottomSheet<dynamic>(
                context: context,
                builder: (_) => BottomSheet(
                  onClosing: () {},
                  builder: (_) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text('テーマを変更'),
                        onTap: () {
                          Navigator.pop(context);
                          showDialog<dynamic>(
                            context: context,
                            child: const SimpleDialog(
                              children: [
                                ThemeSelectorWidget(),
                              ],
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: const Text('ライセンスを表示'),
                        onTap: () {
                          Navigator.pop(context);
                          showAboutDialog(
                            context: context,
                            applicationName: 'CoLiSu',
                            applicationVersion: '1.0.0',
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
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
          // 家(豆・コーヒー)
          _TitleImage(
            image: const AssetImage('assets/coffee.jpg'),
            text: 'Home',
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

          // カフェ (カフェ・コーヒー)
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
                  fontFamily: _fontFamily,
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
      height: (orientation == Orientation.landscape)
          ? MediaQuery.of(context).size.height - kToolbarHeight - 20
          : (MediaQuery.of(context).size.height - kToolbarHeight - 30) / 2,
      child: widget,
    );
  }
}
