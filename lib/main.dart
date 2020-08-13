import 'package:coffee_life_manager/model/cafe.dart';
import 'package:coffee_life_manager/ui/widget/image_card_widget/image_card_widget.dart';
import 'package:flutter/material.dart';

import 'model/bean.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ImageCardWidget(
            imageInformation: Bean(),
            actions: const [
              Icon(Icons.local_cafe),
            ],
          ),
          ImageCardWidget(
            imageInformation: Cafe(),
            actions: const [
              Icon(Icons.local_cafe),
            ],
          ),
        ],
      ),
    );
  }
}
