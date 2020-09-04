import 'package:coffee_life_manager/model/house_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/house_coffee_dao.dart';
import 'package:coffee_life_manager/ui/page/list_page/list_tile/list_tile_viewmodel.dart';
import 'package:flutter/cupertino.dart';

class HouseCoffeeListTileViewModel extends ListTileViewModel {
  HouseCoffeeListTileViewModel(this._dao, this.coffee)
      : isFavorite = ValueNotifier(coffee.isFavorite);

  final HouseCoffeeDao _dao;
  HouseCoffee coffee;
  final ValueNotifier<bool> isFavorite;

  @override
  void onFavChanged(bool val) {
    coffee.isFavorite = isFavorite.value = val;
    _dao.update(coffee);
  }

  @override
  ValueNotifier<bool> getIsFavorite() => isFavorite;

  @override
  HouseCoffee getItem() => coffee;
}
