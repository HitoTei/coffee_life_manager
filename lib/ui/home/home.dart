import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/model/cafe.dart';
import 'package:coffee_life_manager/model/cafe_coffee.dart';
import 'package:coffee_life_manager/model/house_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/bean_dao_impl.dart';
import 'package:coffee_life_manager/repository/model/dao/cafe_coffee_dao_impl.dart';
import 'package:coffee_life_manager/repository/model/dao/cafe_dao_impl.dart';
import 'package:coffee_life_manager/repository/model/dao/house_coffee_dao_impl.dart';
import 'package:coffee_life_manager/ui/page/detail_page/bean_detail_page/bean_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_coffee_detail_page/cafe_coffee_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_detail_page/cafe_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/house_coffee_detail_page/house_coffee_detail_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/bean_list_page/bean_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_coffee_list_page/cafe_coffee_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_list_page/cafe_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/house_coffee_list_page/house_coffee_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
  final beanList = ValueNotifier<List<Bean>>(null);

  final cafeList = ValueNotifier<List<Cafe>>(null);

  final cafeCoffeeList = ValueNotifier<List<CafeCoffee>>(null);

  final houseCoffeeList = ValueNotifier<List<HouseCoffee>>(null);

  @override
  void initState() {
    super.initState();
    BeanDaoImpl().fetchAll().then((value) => beanList.value = value);
    CafeDaoImpl().fetchAll().then((value) => cafeList.value = value);
    CafeCoffeeDaoImpl()
        .fetchAll()
        .then((value) => cafeCoffeeList.value = value);
    HouseCoffeeDaoImpl()
        .fetchAll()
        .then((value) => houseCoffeeList.value = value);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: MyHomePage._tab.length,
      child: Scaffold(
        body: TabBarView(
          children: [
            ValueListenableProvider.value(
              value: beanList,
              child: BeanListPage(),
            ),
            ValueListenableProvider.value(
              value: cafeList,
              child: CafeListPage(),
            ),
            ValueListenableProvider.value(
              value: cafeCoffeeList,
              child: CafeCoffeeListPage(),
            ),
            ValueListenableProvider.value(
              value: houseCoffeeList,
              child: HouseCoffeeListPage(),
            ),
          ],
        ),
        appBar: TabBar(
          labelColor: Theme.of(context).primaryColor,
          tabs: MyHomePage._tab,
        ),

        /*
         *  TODO: Fix
         *  Speed Dial が うまく dock しない
         */
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: const IconThemeData(size: 22),
          curve: Curves.bounceIn,
          children: [
            SpeedDialChild(
              label: '豆',
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
              onTap: () async {
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
            SpeedDialChild(
              label: 'カフェコーヒー',
              onTap: () async {
                final cafeCoffee = CafeCoffee();
                await Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (_) {
                      return CafeCoffeeDetailPage(cafeCoffee);
                    },
                  ),
                );
                cafeCoffeeList.value = [...cafeCoffeeList.value, cafeCoffee];
              },
            ),
            SpeedDialChild(
              label: '家コーヒー',
              onTap: () async {
                final houseCoffee = HouseCoffee();
                await Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (_) {
                      return HouseCoffeeDetailPage(houseCoffee);
                    },
                  ),
                );
                houseCoffeeList.value = [...houseCoffeeList.value, houseCoffee];
              },
            ),
          ],
        ),
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
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
