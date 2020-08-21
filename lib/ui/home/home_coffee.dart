import 'package:coffee_life_manager/model/cafe_coffee.dart';
import 'package:coffee_life_manager/model/house_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/cafe_coffee_dao_impl.dart';
import 'package:coffee_life_manager/repository/model/dao/house_coffee_dao_impl.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_coffee_list_page/cafe_coffee_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/house_coffee_list_page/house_coffee_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeCoffee extends StatefulWidget {
  static const _tab = [
    Tab(text: '家'),
    Tab(text: 'カフェ'),
  ];

  @override
  _HomeCoffeeState createState() => _HomeCoffeeState();
}

class _HomeCoffeeState extends State<HomeCoffee> {
  final cafeCoffeeList = ValueNotifier<List<CafeCoffee>>(null);

  final houseCoffeeList = ValueNotifier<List<HouseCoffee>>(null);

  @override
  void initState() {
    CafeCoffeeDaoImpl()
        .fetchAll()
        .then((value) => cafeCoffeeList.value = value);
    HouseCoffeeDaoImpl()
        .fetchAll()
        .then((value) => houseCoffeeList.value = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    HouseCoffeeDaoImpl().delete(val as HouseCoffee);
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
                    CafeCoffeeDaoImpl().delete(val as CafeCoffee);
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
