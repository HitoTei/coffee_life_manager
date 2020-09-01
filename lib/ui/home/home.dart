import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/model/cafe.dart';
import 'package:coffee_life_manager/ui/home/home_coffee.dart';
import 'package:coffee_life_manager/ui/home/home_makers.dart';
import 'package:coffee_life_manager/ui/home/home_viewmodel.dart';
import 'package:coffee_life_manager/ui/page/detail_page/bean_detail_page/bean_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_detail_page/cafe_detail_page.dart';
import 'package:coffee_life_manager/ui/page/theme_selector/theme_selector_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final viewModel = HomeViewModel();

  @override
  void dispose() {
    viewModel.beanController.close();
    viewModel.cafeController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: MyHomePage._tab.length,
      child: Scaffold(
        body: isMakers
            ? Provider.value(
                value: viewModel,
                child: HomeMakers(),
              )
            : HomeCoffee(),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                      // ここもbottom sheetで
                    },
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.add),
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
              )
            ],
          ),
        ),
      ),
    );
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
              builder: (_) => BeanDetailPage(bean),
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
              builder: (_) => CafeDetailPage(cafe),
            ),
          );
          viewModel.cafeController.add(cafe);
        },
      ),
    ];
  }

  List<Widget> _moreVertMenuListTileList() {
    return [
      ListTile(
        leading: const Icon(Icons.compare_arrows),
        title: const Text('リストを変更する'),
        subtitle: Text(
          '変更後: ${isMakers ? 'コーヒー' : 'カフェ・豆'}',
        ),
        onTap: () {
          setState(() => isMakers = !isMakers);
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: const Icon(Icons.apps),
        title: const Text('テーマを変更する'),
        onTap: () async {
          await Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (_) {
                return ThemeSelectorPage();
              },
            ),
          );
          Navigator.pop(context);
        },
      ),
    ];
  }
}
