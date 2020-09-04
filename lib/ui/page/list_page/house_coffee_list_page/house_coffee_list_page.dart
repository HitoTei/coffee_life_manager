import 'package:coffee_life_manager/model/house_coffee.dart';
import 'package:coffee_life_manager/ui/page/list_page/list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'house_coffee_list_tile.dart';

class HouseCoffeeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coffeeList = context.watch<List<HouseCoffee>>();

    return ListPage(
      coffeeList,
      (dynamic coffee) => Provider.value(
        value: coffee as HouseCoffee,
        child: HouseCoffeeListTile(),
      ),
    );
  }
}
