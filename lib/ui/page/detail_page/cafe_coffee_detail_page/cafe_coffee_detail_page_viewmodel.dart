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

  Future<void> onDispose() {
    return dao.update(coffee);
  }

  final ValueNotifier<bool> isFavorite;
  final ValueNotifier<int> price;
  final ValueNotifier<DateTime> drinkDay;

  void isFavoriteChanged(bool val) {
    isFavorite.value = val;
    coffee.isFavorite = val;
  }

  void priceChanged(int val) {
    price.value = val;
    coffee.price = val;
  }

  void drinkDayChanged(DateTime val) {
    drinkDay.value = val;
    coffee.drinkDay = val;
  }

  void share() {}
}
