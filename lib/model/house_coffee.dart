import '../constant_string.dart';
import 'enums/drip.dart';
import 'enums/grind.dart';
import 'enums/roast.dart';

class HouseCoffee {
  HouseCoffee();
  HouseCoffee.fromMap(Map<String, dynamic> map) {
    uid = map[uidKey] as int;
    beanName = map[beanNameKey] as String;
    numOfCups = map[numOfCupsKey] as int;
    grind = map[grindKey] as Grind;
    drip = map[dripKey] as Drip;
    roast = map[roastKey] as Roast;
    drinkDay = map[drinkDayKey] as DateTime;
    rateId = map[rateIdKey] as int;
    beanId = map[beanIdKey] as int;
    memo = map[memoKey] as String;
    isFavorite = map[isFavoriteKey] as bool;
  }

  int uid;
  String beanName = '';
  int numOfCups;
  Grind grind;
  Drip drip;
  Roast roast;
  DateTime drinkDay;
  int rateId;
  int beanId;
  String memo = '';
  bool isFavorite;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      uidKey: uid,
      beanNameKey: beanName,
      numOfCupsKey: numOfCups,
      grindKey: grind,
      dripKey: drip,
      roastKey: roast,
      drinkDayKey: drinkDay,
      rateIdKey: rateId,
      beanIdKey: beanId,
      memoKey: memo,
      isFavoriteKey: isFavorite,
    };
  }
}
