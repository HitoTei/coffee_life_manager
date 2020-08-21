import 'package:coffee_life_manager/ui/home/home.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.brown,
        primaryColorDark: Colors.brown[800],
        primaryColorLight: Colors.brown[300],
        accentColor: const Color(0xff486c79),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}
