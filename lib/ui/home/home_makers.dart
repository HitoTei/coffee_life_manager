import 'dart:async';

import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/model/cafe.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/bean_dao.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/cafe_dao.dart';
import 'package:coffee_life_manager/ui/home/home_viewmodel.dart';
import 'package:coffee_life_manager/ui/page/list_page/bean_list_page/bean_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_list_page/cafe_list_page.dart';
import 'package:flutter/material.dart';
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

  StreamSubscription subBean, subCafe;

  BeanDao _beanDao;
  CafeDao _cafeDao;

  void _fetchList() {
    _beanDao = context.watch();
    _cafeDao = context.watch();
    final favoriteOnly = context.watch<bool>();

    if (favoriteOnly) {
      _beanDao.fetchFavorite().then((value) => beanList.value = value);
      _cafeDao.fetchFavorite().then((value) => cafeList.value = value);
    } else {
      _beanDao.fetchAll().then((value) => beanList.value = value);
      _cafeDao.fetchAll().then((value) => cafeList.value = value);
    }
  }

  @override
  void initState() {
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    subBean = viewModel.beanController.stream.listen((event) {
      beanList.value = [...beanList.value, event];
    });
    subCafe = viewModel.cafeController.stream.listen((event) {
      cafeList.value = [...cafeList.value, event];
    });
    super.initState();
  }

  @override
  void dispose() {
    subBean.cancel();
    subCafe.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _fetchList();
    return DefaultTabController(
      length: HomeMakers._tab.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: kToolbarHeight,
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
                    _beanDao.delete(val as Bean);
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
                    _cafeDao.delete(val as Cafe);
                    cafeList.value.remove(val);
                    cafeList.value = [...cafeList.value];
                  },
                ),
              ],
              child: CafeListPage(),
            ),
          ],
        ),
      ),
    );
  }
}
