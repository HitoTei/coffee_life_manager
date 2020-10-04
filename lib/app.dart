import 'package:coffee_life_manager/l10n/l10n.dart';
import 'package:coffee_life_manager/ui/page/detail_page/bean_detail/bean_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_detail/cafe_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/house_coffee_detail/add_house_coffee_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/house_coffee_detail/house_coffee_detail_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/bean_list/bean_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_list/cafe_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/all.dart';

import 'ui/page/detail_page/cafe_coffee_detail/cafe_coffee_detail_page.dart';
import 'ui/page/list_page/cafe_coffee_list/cafe_coffee_list_page.dart';
import 'ui/page/list_page/house_coffee_list/house_coffee_list_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: _MyApp(),
    );
  }
}

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      initialRoute: BeanListPage.routeName,
      routes: {
        BeanListPage.routeName: (_) => const BeanListPage(),
        BeanDetailPage.routeName: (_) => const BeanDetailPage(),
        CafeListPage.routeName: (_) => const CafeListPage(),
        CafeDetailPage.routeName: (_) => const CafeDetailPage(),
        CafeCoffeeListPage.routeName: (_) => const CafeCoffeeListPage(),
        CafeCoffeeDetailPage.routeName: (_) => const CafeCoffeeDetailPage(),
        HouseCoffeeListPage.routeName: (_) => const HouseCoffeeListPage(),
        HouseCoffeeDetailPage.routeName: (_) => const HouseCoffeeDetailPage(),
        AddHouseCoffeePage.routeName: (_) => const AddHouseCoffeePage(),
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        L10n.delegate,
      ],
      locale: const Locale('ja'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ja'),
      ],
    );
  }
}
