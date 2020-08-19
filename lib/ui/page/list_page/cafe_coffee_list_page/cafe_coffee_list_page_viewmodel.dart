import 'package:coffee_life_manager/model/cafe_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/cafe_coffee_dao.dart';

class CafeCoffeeListPageViewModel {
  CafeCoffeeListPageViewModel(this._dao);

  final CafeCoffeeDao _dao;

  void onFavChanged(CafeCoffee coffee) {
    _dao.update(coffee);
  }
}
