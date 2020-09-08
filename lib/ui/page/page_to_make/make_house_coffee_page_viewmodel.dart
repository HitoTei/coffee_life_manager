import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/model/enums/drip.dart';
import 'package:coffee_life_manager/model/enums/grind.dart';
import 'package:coffee_life_manager/model/house_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/bean_dao.dart';
import 'package:flutter/cupertino.dart';

class MakeHouseCoffeePageViewModel {
  MakeHouseCoffeePageViewModel(this.bean, this.beanDao)
      : coffee = HouseCoffee()
          ..roast = bean.roast
          ..beanName = bean.beanName
          ..beanId = bean.uid
          ..drinkDay = DateTime.now(),
        drip = ValueNotifier(Drip.values[0]),
        grind = ValueNotifier(Grind.values[0]);

  final Bean bean;
  final HouseCoffee coffee;

  final BeanDao beanDao;

  final ValueNotifier<Drip> drip;
  final ValueNotifier<Grind> grind;
  final cup = ValueNotifier(1);

  void dripChanged(Drip val) {
    drip.value = val;
    coffee.drip = val;
  }

  void grindChanged(Grind val) {
    grind.value = val;
    coffee.grind = val;
  }

  bool cupChanged(int val) {
    if (val * bean.oneCupPerGram <= bean.remainingAmount) {
      cup.value = val;
      coffee.numOfCups = cup.value;
      return true;
    }
    return false;
  }

  void cupIncrement() {
    if ((cup.value + 1) * bean.oneCupPerGram <= bean.remainingAmount) {
      cup.value += 1;
      coffee.numOfCups = cup.value;
    }
  }

  void cupDecrement() {
    if (cup.value > 1) {
      cup.value -= 1;
      coffee.numOfCups = cup.value;
    }
  }

  void save() {
    bean.remainingAmount -= coffee.numOfCups * bean.oneCupPerGram;
    beanDao.update(bean);
  }
}
