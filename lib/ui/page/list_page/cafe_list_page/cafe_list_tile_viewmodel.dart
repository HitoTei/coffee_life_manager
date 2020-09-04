import 'package:coffee_life_manager/model/cafe.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/cafe_dao.dart';
import 'package:coffee_life_manager/ui/page/list_page/list_tile/list_tile_viewmodel.dart';
import 'package:flutter/cupertino.dart';

class CafeListTileViewModel extends ListTileViewModel {
  CafeListTileViewModel(this._dao, this.cafe)
      : isFavorite = ValueNotifier(cafe.isFavorite);

  final CafeDao _dao;
  Cafe cafe;
  final ValueNotifier<bool> isFavorite;

  void onFavChanged(bool val) {
    cafe.isFavorite = isFavorite.value = val;
    _dao.update(cafe);
  }

  @override
  ValueNotifier<bool> getIsFavorite() => isFavorite;

  @override
  Cafe getItem() => cafe;
}
