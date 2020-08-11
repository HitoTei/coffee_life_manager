import 'package:coffee_life_manager/function/int_bool_parse.dart';
import 'package:coffee_life_manager/model/rate.dart';

import '../constant_string.dart';
import 'enums/roast.dart';

class Bean {
  Bean();

  Bean.fromMap(Map<String, dynamic> map) {
    uid = map[uidKey] as int;
    beanName = map[beanNameKey] as String;
    remainingAmount = map[remainingAmountKey] as int;
    oneCupPerGram = map[oneCupPerGramKey] as int;
    price = map[priceKey] as int;
    shopId = map[shopIdKey] as int;
    memo = map[memoKey] as String;

    roast = Roast.values[map[roastKey] as int];
    freshnessDate = DateTime.parse(map[freshnessDateKey] as String);
    openTime = DateTime.parse(map[openTimeKey] as String);
    rate = Rate.fromJsonStr(map[rateKey] as String);
    isFavorite = map[isFavoriteKey] as bool;
  }

  int uid;
  String beanName = '';
  int remainingAmount = 0; // 残量
  int oneCupPerGram = 10; // 一杯当たりの豆の量
  Roast roast = Roast.values[0]; // 焙煎
  DateTime freshnessDate; // 賞味期限
  DateTime openTime; // 開封日時
  int price = 0; // 値段
  Rate rate = Rate(); // 評価
  int shopId;
  String memo = ''; // メモ
  bool isFavorite = false; // お気に入りか

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      uidKey: uid,
      beanNameKey: beanName,
      remainingAmountKey: remainingAmount,
      oneCupPerGramKey: oneCupPerGram,
      priceKey: price,
      shopIdKey: shopId,
      memoKey: memo,

      // Sqliteで扱えないので扱える型にする
      rateKey: rate.toJsonStr(),
      roastKey: roast.index,
      freshnessDateKey: freshnessDate.toString(),
      openTimeKey: openTime.toString(),
      isFavoriteKey: boolToInt(isFavorite),
    };
  }
}
