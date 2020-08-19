import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/bean_dao.dart';

class BeanListPageViewModel {
  BeanListPageViewModel(this._dao);

  final BeanDao _dao;

  void onFavChanged(Bean bean) {
    _dao.update(bean);
  }
}
