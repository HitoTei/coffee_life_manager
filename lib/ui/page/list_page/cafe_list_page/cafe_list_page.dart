import 'package:coffee_life_manager/model/cafe.dart';
import 'package:coffee_life_manager/ui/page/list_page/list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cafe_list_tile.dart';

class CafeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cafeList = Provider.of<List<Cafe>>(context);
    return ListPage(
      cafeList,
      (dynamic cafe) => Provider.value(
        value: cafe as Cafe,
        child: CafeListTile(),
      ),
    );
  }
}
