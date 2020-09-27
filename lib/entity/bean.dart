import 'package:coffee_life_manager/function/int_bool_parse.dart';
import 'package:coffee_life_manager/model/interface/image_card_information.dart';
import 'package:coffee_life_manager/model/rate.dart';

import '../constant_string.dart';
import 'enums/roast.dart';

class Bean implements ImageCardInformation {
  Bean();

  Bean.copy(Bean bean) {
    uid = bean.uid;
    beanName = bean.beanName;
    remainingAmount = bean.remainingAmount;
    oneCupPerGram = bean.oneCupPerGram;
    price = bean.price;
    cafeId = bean.cafeId;
    memo = bean.memo;
    imageUri = bean.imageUri;
    firstAmount = bean.firstAmount;
    roast = bean.roast;
    freshnessDate = bean.freshnessDate;
    openTime = bean.openTime;
    rate = bean.rate;
    isFavorite = bean.isFavorite;
  }

  Bean.fromMap(Map<String, dynamic> map) {
    uid = map[uidKey] as int;
    beanName = map[beanNameKey] as String;
    remainingAmount = map[remainingAmountKey] as int;
    oneCupPerGram = map[oneCupPerGramKey] as int;
    price = map[priceKey] as int;
    cafeId = map[cafeIdKey] as int;
    memo = map[memoKey] as String;
    imageUri = map[imageUriKey] as String;
    firstAmount = map[firstAmountKey] as int;

    roast = Roast.values[map[roastKey] as int];
    freshnessDate = (map[freshnessDateKey] as String == 'null')
        ? null
        : DateTime.parse(map[freshnessDateKey] as String);
    openTime = (map[openTimeKey] as String == 'null')
        ? null
        : DateTime.parse(map[openTimeKey] as String);
    rate = Rate.fromJsonStr(map[rateKey] as String);
    isFavorite = intToBool(map[isFavoriteKey] as int);
  }

  int uid;
  String beanName = '';
  int remainingAmount = 100; // 残量
  int firstAmount = 100; // 最初の量
  int oneCupPerGram = 10; // 一杯当たりの豆の量
  Roast roast = Roast.values[0]; // 焙煎
  DateTime freshnessDate; // 賞味期限
  DateTime openTime; // 開封日時
  int price = 0; // 値段
  Rate rate = Rate(); // 評価
  int cafeId;
  String memo = ''; // メモ
  String imageUri;
  bool isFavorite = false; // お気に入りか

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      uidKey: uid,
      beanNameKey: beanName,
      remainingAmountKey: remainingAmount,
      oneCupPerGramKey: oneCupPerGram,
      priceKey: price,
      cafeIdKey: cafeId,
      memoKey: memo,
      imageUriKey: imageUri,
      firstAmountKey: firstAmount,

      // Sqliteで扱えないので扱える型にする
      rateKey: rate.toJsonStr(),
      roastKey: roast.index,
      freshnessDateKey: freshnessDate.toString(),
      openTimeKey: openTime.toString(),
      isFavoriteKey: boolToInt(isFavorite),
    };
  }

  @override
  String getImageUri() => imageUri;

  @override
  void setImageUri(String value) => imageUri = value;

  @override
  String getTitle() => beanName;

  @override
  void setTitle(String value) => beanName = value;

  @override
  String getMessage() => '${remainingAmount}g';
}
