import 'package:coffee_life_manager/function/int_bool_parse.dart';
import 'package:coffee_life_manager/model/rate.dart';

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
    beanId = map[beanIdKey] as int;
    memo = map[memoKey] as String;
    imageUri = map[imageUriKey] as String;

    grind = Grind.values[map[grindKey] as int];
    drip = Drip.values[map[dripKey] as int];
    roast = Roast.values[map[roastKey] as int];
    drinkDay = DateTime.parse(map[drinkDayKey] as String);
    rate = Rate.fromJsonStr(map[rateKey] as String);
    isFavorite = intToBool(map[isFavoriteKey] as int);
  }

  int uid;
  String beanName = '';
  int numOfCups = 1;
  Grind grind = Grind.values[0];
  Drip drip = Drip.values[0];
  Roast roast = Roast.values[0];
  DateTime drinkDay;
  Rate rate = Rate();
  int beanId;
  String memo = '';
  String imageUri;
  bool isFavorite = false;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      uidKey: uid,
      beanNameKey: beanName,
      numOfCupsKey: numOfCups,
      beanIdKey: beanId,
      memoKey: memo,
      imageUriKey: imageUri,
      // Sqliteで扱えないので扱える型にする
      grindKey: grind.index,
      dripKey: drip.index,
      roastKey: roast.index,
      drinkDayKey: drinkDay.toString(),
      rateKey: rate.toJsonStr(),
      isFavoriteKey: boolToInt(isFavorite),
    };
  }
}
