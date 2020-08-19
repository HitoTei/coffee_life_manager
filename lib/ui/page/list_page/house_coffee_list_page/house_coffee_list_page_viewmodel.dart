import 'package:coffee_life_manager/model/house_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/house_coffee_dao.dart';

class HouseCoffeeListPageViewModel {
  HouseCoffeeListPageViewModel(this._dao);

  final HouseCoffeeDao _dao;

  void onFavChanged(HouseCoffee coffee) {
    _dao.update(coffee);
  }
}
