import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/model/enums/roast.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/bean_dao.dart';
import 'package:flutter/cupertino.dart';

class BeanDetailPageViewModel {
  BeanDetailPageViewModel(this.bean, this.dao)
      : isFavorite = ValueNotifier(bean.isFavorite),
        remainingAmount = ValueNotifier(bean.remainingAmount),
        oneCupPerGram = ValueNotifier(bean.oneCupPerGram),
        price = ValueNotifier(bean.price),
        freshnessDate = ValueNotifier(bean.freshnessDate),
        openTime = ValueNotifier(bean.openTime),
        roast = ValueNotifier(bean.roast);

  final Bean bean;
  final BeanDao dao;

  void onInitState() {
    if (bean.uid == null) {
      dao.insert(bean).then((value) => bean.uid = value);
    }
  }

  void onDispose() {
    dao.update(bean);
  }

  bool canDripCoffee() => bean.remainingAmount < bean.oneCupPerGram;

  final ValueNotifier<bool> isFavorite;
  final ValueNotifier<int> remainingAmount;
  final ValueNotifier<int> oneCupPerGram;
  final ValueNotifier<int> price;
  final ValueNotifier<DateTime> freshnessDate;
  final ValueNotifier<DateTime> openTime;
  final ValueNotifier<Roast> roast;

  void share() {}
}
