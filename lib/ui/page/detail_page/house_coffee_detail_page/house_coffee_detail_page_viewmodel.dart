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

  Future<void> onDispose() {
    return dao.update(coffee);
  }

  final ValueNotifier<bool> isFavorite;
  final ValueNotifier<DateTime> drinkDay;
  final ValueNotifier<int> numOfCups;
  final ValueNotifier<Roast> roast;
  final ValueNotifier<Grind> grind;
  final ValueNotifier<Drip> drip;

  void isFavoriteChanged(bool val) {
    isFavorite.value = val;
    coffee.isFavorite = val;
  }

  void drinkDayChanged(DateTime val) {}

  void numOfCupsChanged(int val) {
    numOfCups.value = val;
    coffee.numOfCups = val;
  }

  void roastChanged(Roast val) {
    roast.value = val;
    coffee.roast = val;
  }

  void grindChanged(Grind val) {
    grind.value = val;
    coffee.grind = val;
  }

  void dripChanged(Drip val) {
    drip.value = val;
    coffee.drip = val;
  }

  void share() {}
}
