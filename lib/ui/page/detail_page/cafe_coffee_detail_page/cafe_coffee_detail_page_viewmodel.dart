import 'package:coffee_life_manager/model/cafe_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/cafe_coffee_dao.dart';
import 'package:flutter/cupertino.dart';

class CafeCoffeeDetailPageViewModel {
  CafeCoffeeDetailPageViewModel(this.coffee, this.dao)
      : isFavorite = ValueNotifier(coffee.isFavorite),
        price = ValueNotifier(coffee.price),
        drinkDay = ValueNotifier(coffee.drinkDay);
  final CafeCoffee coffee;
  final CafeCoffeeDao dao;

  void onInitState() {
    if (coffee.uid == null) {
      dao.insert(coffee).then((value) => coffee.uid = value);
    }
  }

  void onDispose() {
    dao.update(coffee);
  }

  final ValueNotifier<bool> isFavorite;
  final ValueNotifier<int> price;
  final ValueNotifier<DateTime> drinkDay;

  void share() {}
}
