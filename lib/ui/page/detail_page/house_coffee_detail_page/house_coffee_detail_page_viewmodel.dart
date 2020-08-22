import 'package:coffee_life_manager/model/enums/drip.dart';
import 'package:coffee_life_manager/model/enums/grind.dart';
import 'package:coffee_life_manager/model/enums/roast.dart';
import 'package:coffee_life_manager/model/house_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/house_coffee_dao.dart';
import 'package:flutter/material.dart';

class HouseCoffeeDetailPageViewModel {
  HouseCoffeeDetailPageViewModel(this.coffee, this.dao)
      : isFavorite = ValueNotifier(coffee.isFavorite),
        drinkDay = ValueNotifier(coffee.drinkDay),
        numOfCups = ValueNotifier(coffee.numOfCups),
        roast = ValueNotifier(coffee.roast),
        grind = ValueNotifier(coffee.grind),
        drip = ValueNotifier(coffee.drip);

  final HouseCoffee coffee;
  final HouseCoffeeDao dao;

  void onInitState() {
    if (coffee.uid == null) {
      dao.insert(coffee).then((value) => coffee.uid = value);
    }
  }

  void onDispose() {
    dao.update(coffee);
  }

  final ValueNotifier<bool> isFavorite;
  final ValueNotifier<DateTime> drinkDay;
  final ValueNotifier<int> numOfCups;
  final ValueNotifier<Roast> roast;
  final ValueNotifier<Grind> grind;
  final ValueNotifier<Drip> drip;

  void share() {}
}