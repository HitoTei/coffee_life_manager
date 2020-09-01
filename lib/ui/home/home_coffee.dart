import 'package:coffee_life_manager/model/cafe_coffee.dart';
import 'package:coffee_life_manager/model/house_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/cafe_coffee_dao.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/house_coffee_dao.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_coffee_list_page/cafe_coffee_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/house_coffee_list_page/house_coffee_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeCoffee extends StatefulWidget {
  static const _tab = [
    Tab(text: '家コーヒー'),
    Tab(text: 'カフェコーヒー'),
  ];

  @override
  _HomeCoffeeState createState() => _HomeCoffeeState();
}

class _HomeCoffeeState extends State<HomeCoffee> {
  final cafeCoffeeList = ValueNotifier<List<CafeCoffee>>(null);

  final houseCoffeeList = ValueNotifier<List<HouseCoffee>>(null);

  CafeCoffeeDao _cafeCoffeeDao;
  HouseCoffeeDao _houseCoffeeDao;

  void _fetchList() {
    _cafeCoffeeDao = context.watch();
    _houseCoffeeDao = context.watch();
    final favoriteOnly = context.watch<bool>();

    if (favoriteOnly) {
      _cafeCoffeeDao
          .fetchFavorite()
          .then((value) => cafeCoffeeList.value = value);
      _houseCoffeeDao
          .fetchFavorite()
          .then((value) => houseCoffeeList.value = value);
    } else {
      _cafeCoffeeDao.fetchAll().then((value) => cafeCoffeeList.value = value);
      _houseCoffeeDao.fetchAll().then((value) => houseCoffeeList.value = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    _fetchList();
    return DefaultTabController(
      length: HomeCoffee._tab.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: kToolbarHeight,
          bottom: const TabBar(
            tabs: HomeCoffee._tab,
          ),
        ),
        body: TabBarView(
          children: [
            MultiProvider(
              providers: [
                ValueListenableProvider.value(value: houseCoffeeList),
                Provider<Function(dynamic)>.value(
                  value: (dynamic val) {
                    _houseCoffeeDao.delete(val as HouseCoffee);
                    houseCoffeeList.value.remove(val);
                    houseCoffeeList.value = [...houseCoffeeList.value];
                  },
                ),
              ],
              child: HouseCoffeeListPage(),
            ),
            MultiProvider(
              providers: [
                ValueListenableProvider.value(
                  value: cafeCoffeeList,
                ),
                Provider<Function(dynamic)>.value(
                  value: (dynamic val) {
                    _cafeCoffeeDao.delete(val as CafeCoffee);
                    cafeCoffeeList.value.remove(val);
                    cafeCoffeeList.value = [...cafeCoffeeList.value];
                  },
                ),
              ],
              child: CafeCoffeeListPage(),
            ),
          ],
        ),
      ),
    );
  }
}
