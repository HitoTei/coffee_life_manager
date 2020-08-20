import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/model/cafe.dart';
import 'package:coffee_life_manager/repository/model/dao/bean_dao_impl.dart';
import 'package:coffee_life_manager/repository/model/dao/cafe_dao_impl.dart';
import 'package:coffee_life_manager/ui/page/detail_page/bean_detail_page/bean_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_detail_page/cafe_detail_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/bean_list_page/bean_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_list_page/cafe_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class HomeMakers extends StatefulWidget {
  static const _tab = [
    Tab(text: '豆'),
    Tab(text: 'カフェ'),
  ];

  @override
  _HomeMakersState createState() => _HomeMakersState();
}

class _HomeMakersState extends State<HomeMakers> {
  final beanList = ValueNotifier<List<Bean>>(null);
  final cafeList = ValueNotifier<List<Cafe>>(null);

  @override
  void initState() {
    BeanDaoImpl().fetchAll().then((value) => beanList.value = value);
    CafeDaoImpl().fetchAll().then((value) => cafeList.value = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: HomeMakers._tab.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: HomeMakers._tab,
          ),
        ),
        body: TabBarView(
          children: [
            MultiProvider(
              providers: [
                ValueListenableProvider.value(value: beanList),
                Provider<Function(dynamic)>.value(
                  value: (dynamic val) {
                    BeanDaoImpl().delete(val as Bean);
                    beanList.value.remove(val);
                    beanList.value = [...beanList.value];
                  },
                ),
              ],
              child: BeanListPage(),
            ),
            MultiProvider(
              providers: [
                ValueListenableProvider.value(value: cafeList),
                Provider<Function(dynamic)>.value(
                  value: (dynamic val) {
                    CafeDaoImpl().delete(val as Cafe);
                    cafeList.value.remove(val);
                    cafeList.value = [...cafeList.value];
                  },
                ),
              ],
              child: CafeListPage(),
            ),
          ],
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: const IconThemeData(size: 22),
          curve: Curves.bounceIn,
          overlayOpacity: 0,
          children: [
            SpeedDialChild(
              label: '豆',
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              child: const Icon(Icons.local_cafe),
              onTap: () async {
                final bean = Bean();
                await Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (_) {
                      return BeanDetailPage(bean);
                    },
                  ),
                );
                beanList.value = [...beanList.value, bean];
              },
            ),
            SpeedDialChild(
              label: 'カフェ',
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              child: IconButton(
                icon: const Icon(Icons.store),
                onPressed: () async {
                  final cafe = Cafe();
                  await Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (_) {
                        return CafeDetailPage(cafe);
                      },
                    ),
                  );
                  cafeList.value = [...cafeList.value, cafe];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
