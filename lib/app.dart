import 'package:coffee_life_manager/theme_manager.dart';
import 'package:coffee_life_manager/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableProvider(
      create: (_) => ThemeManager(),
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
    );
  }
}
