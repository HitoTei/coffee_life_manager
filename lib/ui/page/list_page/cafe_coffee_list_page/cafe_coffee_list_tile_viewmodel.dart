import 'package:coffee_life_manager/model/cafe_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/cafe_coffee_dao.dart';
import 'package:coffee_life_manager/ui/page/list_page/list_tile/list_tile_viewmodel.dart';
import 'package:flutter/material.dart';

class CafeCoffeeListTileViewModel extends ListTileViewModel {
  CafeCoffeeListTileViewModel(this._dao, this.coffee)
      : isFavorite = ValueNotifier(coffee.isFavorite);

  final CafeCoffeeDao _dao;
  final ValueNotifier<bool> isFavorite;
  CafeCoffee coffee;

  @override
  void onFavChanged(bool val) {
    isFavorite.value = coffee.isFavorite = val;
    _dao.update(coffee);
  }

  @override
  ValueNotifier<bool> getIsFavorite() => isFavorite;

  @override
  CafeCoffee getItem() => coffee;
}
