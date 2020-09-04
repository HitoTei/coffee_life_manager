import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/ui/page/list_page/list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bean_list_tile.dart';

class BeanListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final beanList = context.watch<List<Bean>>();
    return ListPage(
      beanList,
      (dynamic bean) => Provider.value(
        value: bean as Bean,
        child: BeanListTile(),
      ),
    );
  }
}
