import 'package:coffee_life_manager/model/cafe_coffee.dart';
import 'package:coffee_life_manager/ui/page/list_page/list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cafe_coffee_list_tile.dart';

class CafeCoffeeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coffeeList = context.watch<List<CafeCoffee>>();
    return ListPage(
      coffeeList,
      (dynamic coffee) => Provider.value(
        value: coffee as CafeCoffee,
        child: CafeCoffeeListTile(),
      ),
    );
  }
}
