import 'package:coffee_life_manager/function/sort_compare.dart';
import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/model/cafe.dart';
import 'package:coffee_life_manager/ui/home/home_coffee.dart';
import 'package:coffee_life_manager/ui/home/home_makers.dart';
import 'package:coffee_life_manager/ui/home/home_viewmodel.dart';
import 'package:coffee_life_manager/ui/page/detail_page/bean_detail_page/bean_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_detail_page/cafe_detail_page.dart';
import 'package:coffee_life_manager/ui/page/setting_page/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  static const _tab = [
    Tab(text: '豆'),
    Tab(text: 'カフェ'),
    Tab(text: 'カフェコーヒー'),
    Tab(text: '家コーヒー'),
  ];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isMakers = true;
  final favoriteOnly = ValueNotifier(false);
  final viewModel = HomeViewModel();

  @override
  void dispose() {
    viewModel.beanController.close();
    viewModel.cafeController.close();
    SharedPreferences.getInstance().then(
      (value) => value.setBool('isAsc', isAsc),
    );
    super.dispose();
  }

  @override
  void initState() {
    SharedPreferences.getInstance().then(
      (value) => setState(() => isAsc = value.getBool('isAsc') ?? true),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: MyHomePage._tab.length,
      child: Scaffold(
        body: isMakers
            ? MultiProvider(
                providers: [
                  Provider.value(
                    value: viewModel,
            ),
            ValueListenableProvider.value(value: favoriteOnly),
          ],
          child: HomeMakers(),
        )
            : MultiProvider(
          providers: [
            ValueListenableProvider.value(value: favoriteOnly),
          ],
          child: HomeCoffee(),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet<dynamic>(
              context: context,
              builder: (_) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _addMenuListTileList(),
                );
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          notchMargin: 6,
          shape: const AutomaticNotchedShape(
            RoundedRectangleBorder(),
            StadiumBorder(
              side: BorderSide(),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  showModalBottomSheet<dynamic>(
                    context: context,
                    builder: (_) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _moreVertMenuListTileList(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () {
                  showModalBottomSheet<dynamic>(
                    context: context,
                    builder: (_) =>
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: _sortMenuListTileList(),
                        ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _sortMenuListTileList() {
    return [
      ListTile(
        title: const Text('新しく追加した順'),
        onTap: () {
          setState(() {
            isAsc = true;
            Navigator.pop(context);
          });
        },
        enabled: !isAsc,
      ),
      ListTile(
        title: const Text('古く追加した順'),
        onTap: () {
          setState(
                () {
              isAsc = false;
              Navigator.pop(context);
            },
          );
        },
        enabled: isAsc,
      )
    ];
  }

  List<Widget> _addMenuListTileList() {
    return [
      ListTile(
        leading: const Icon(Icons.local_cafe),
        title: const Text('豆を追加'),
        onTap: () async {
          Navigator.pop(context);
          final bean = Bean();
          await Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (_) => Provider.value(
                value: bean,
                child: BeanDetailPage(),
              ),
            ),
          );
          viewModel.beanController.add(bean);
        },
      ),
      ListTile(
        leading: const Icon(Icons.store),
        title: const Text('カフェを追加'),
        onTap: () async {
          Navigator.pop(context);
          final cafe = Cafe();
          await Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (_) => Provider.value(
                value: cafe,
                child: CafeDetailPage(),
              ),
            ),
          );
          viewModel.cafeController.add(cafe);
        },
      ),
    ];
  }

  List<Widget> _moreVertMenuListTileList() {
    final fav = favoriteOnly.value;

    return [
      ListTile(
        leading: Icon(fav ? Icons.favorite_border : Icons.favorite),
        title: Text(fav ? '全て表示する' : 'お気に入りのみ表示する'),
        onTap: () {
          setState(() {
            favoriteOnly.value = !fav;
          });
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: fav ? '全て表示しています' : 'お気に入りのみ表示しています',
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.compare_arrows),
        title: const Text('リストを変更する'),
        subtitle: Text(
          '${isMakers ? 'コーヒー' : 'カフェ・豆'}のリストを表示する',
        ),
        onTap: () {
          setState(() => isMakers = !isMakers);
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: '${isMakers ? 'カフェ・豆' : 'コーヒー'}のリストを表示しています',
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.settings),
        title: const Text('設定'),
        onTap: () async {
          await Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (_) {
                return SettingPage();
              },
            ),
          );
          Navigator.pop(context);
        },
      ),
    ];
  }
}
