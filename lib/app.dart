import 'package:coffee_life_manager/l10n/l10n.dart';
import 'package:coffee_life_manager/ui/page/list_page/bean_list/bean_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/all.dart';

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
      home: BeanListPage(),
      // TODO: replace
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
