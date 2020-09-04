import 'package:coffee_life_manager/l10n/l10n.dart';
import 'package:coffee_life_manager/repository/model/dao/bean_dao_impl.dart';
import 'package:coffee_life_manager/repository/model/dao/cafe_coffee_dao_impl.dart';
import 'package:coffee_life_manager/repository/model/dao/cafe_dao_impl.dart';
import 'package:coffee_life_manager/repository/model/dao/house_coffee_dao_impl.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/cafe_coffee_dao.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/house_coffee_dao.dart';
import 'package:coffee_life_manager/theme_manager.dart';
import 'package:coffee_life_manager/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'repository/model/dao/interface/bean_dao.dart';
import 'repository/model/dao/interface/cafe_dao.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ValueListenableProvider(
          create: (_) => ThemeManager(),
        ),
        Provider<BeanDao>.value(value: BeanDaoImpl()),
        Provider<CafeDao>.value(value: CafeDaoImpl()),
        Provider<HouseCoffeeDao>.value(value: HouseCoffeeDaoImpl()),
        Provider<CafeCoffeeDao>.value(value: CafeCoffeeDaoImpl()),
      ],
      child: _MyApp(),
    );
  }
}

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeData>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: MyHomePage(),
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
