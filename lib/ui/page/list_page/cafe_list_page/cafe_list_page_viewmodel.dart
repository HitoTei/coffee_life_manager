import 'package:coffee_life_manager/model/cafe.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/cafe_dao.dart';

class CafeListPageViewModel {
  CafeListPageViewModel(this._dao);

  final CafeDao _dao;

  void onFavChanged(Cafe cafe) {
    _dao.update(cafe);
  }
}
