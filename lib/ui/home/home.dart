import 'package:coffee_life_manager/ui/home/home_coffee.dart';
import 'package:coffee_life_manager/ui/home/home_makers.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  static const _tab = [
    Tab(text: '豆'),
    Tab(text: 'カフェ'),
    Tab(text: 'カフェコーヒー'),
    Tab(text: '家コーヒー'),
  ];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isMakers = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: MyHomePage._tab.length,
      child: Scaffold(
        body: isMakers ? HomeMakers() : HomeCoffee(),

        /*
         *  TODO: Fix
         *  Speed Dial が うまく dock しない
         */

        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomAppBar(
          notchMargin: 6,
          shape: const AutomaticNotchedShape(
            RoundedRectangleBorder(),
            StadiumBorder(
              side: BorderSide(),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.compare_arrows),
                onPressed: () {
                  setState(() {
                    isMakers = !isMakers;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
