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

  Future<void> onInitState() async {
    if (bean.uid == null) {
      await dao.insert(bean).then((value) => bean.uid = value);
    }
  }

  Future<void> onDispose() {
    return dao.update(bean);
  }

  bool canDripCoffee() => bean.remainingAmount < bean.oneCupPerGram;

  final ValueNotifier<bool> isFavorite;
  final ValueNotifier<int> remainingAmount;
  final ValueNotifier<int> oneCupPerGram;
  final ValueNotifier<int> price;
  final ValueNotifier<DateTime> freshnessDate;
  final ValueNotifier<DateTime> openTime;
  final ValueNotifier<Roast> roast;

  void isFavoriteChanged(bool val) {
    isFavorite.value = val;
    bean.isFavorite = val;
  }

  void remainingAmountChanged(int val) {
    remainingAmount.value = val;
    bean.remainingAmount = val;
  }

  void oneCupPerGramChanged(int val) {
    oneCupPerGram.value = val;
    bean.oneCupPerGram = val;
  }

  void priceChanged(int val) {
    price.value = val;
    bean.price = val;
  }

  void freshnessDateChanged(DateTime val) {
    freshnessDate.value = val;
    bean.freshnessDate = val;
  }

  void openTimeChanged(DateTime val) {
    openTime.value = val;
    bean.openTime = val;
  }

  void roastChanged(Roast val) {
    roast.value = val;
    bean.roast = val;
  }

  void share() {}
}
