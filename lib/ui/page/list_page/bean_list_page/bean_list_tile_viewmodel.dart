import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/bean_dao.dart';
import 'package:coffee_life_manager/ui/page/list_page/list_tile/list_tile_viewmodel.dart';
import 'package:flutter/cupertino.dart';

class BeanListTileViewModel extends ListTileViewModel {
  BeanListTileViewModel(this._dao, this.bean)
      : isFavorite = ValueNotifier(bean.isFavorite);

  final BeanDao _dao;
  Bean bean;
  final ValueNotifier<bool> isFavorite;

  @override
  void onFavChanged(bool val) {
    isFavorite.value = bean.isFavorite = val;
    _dao.update(bean);
  }

  @override
  ValueNotifier<bool> getIsFavorite() => isFavorite;

  @override
  Bean getItem() => bean;
}
