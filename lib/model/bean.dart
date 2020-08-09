import '../constant_string.dart';
import 'enums/roast.dart';

class Bean {
  Bean();
  Bean.fromMap(Map<String, dynamic> map) {
    uid = map[uidKey] as int;
    beanName = map[beanNameKey] as String;
    remainingAmount = map[remainingAmountKey] as int;
    oneCupPerGram = map[oneCupPerGramKey] as int;
    roast = map[brewingKey] as Roast;
    freshnessDate = map[freshnessDateKey] as DateTime;
    openTime = map[openTimeKey] as DateTime;
    price = map[priceKey] as int;
    rateId = map[rateIdKey] as int;
    shopId = map[shopIdKey] as int;
    memo = map[memoKey] as String;
    isFavorite = map[isFavoriteKey] as bool;
  }

  int uid;
  String beanName = '';
  int remainingAmount = 0; // 残量
  int oneCupPerGram = 10; // 一杯当たりの豆の量
  Roast roast; // 焙煎
  DateTime freshnessDate; // 賞味期限
  DateTime openTime; // 開封日時
  int price; // 値段
  int rateId; // レートid
  int shopId;
  String memo = ''; // メモ
  bool isFavorite; // お気に入りか

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      uidKey: uid,
      beanNameKey: beanName,
      remainingAmountKey: remainingAmount,
      oneCupPerGramKey: oneCupPerGram,
      brewingKey: roast,
      freshnessDateKey: freshnessDate,
      openTimeKey: openTime,
      priceKey: price,
      rateIdKey: rateId,
      shopIdKey: shopId,
      memoKey: memo,
      isFavoriteKey: isFavorite
    };
  }
}
