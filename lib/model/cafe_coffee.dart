import 'package:coffee_life_manager/function/int_bool_parse.dart';
import 'package:coffee_life_manager/model/interface/image_card_information.dart';
import 'package:coffee_life_manager/model/rate.dart';

import '../constant_string.dart';

class CafeCoffee implements ImageCardInformation {
  CafeCoffee();

  CafeCoffee.fromMap(Map<String, dynamic> map) {
    uid = map[uidKey] as int;
    productName = map[productNameKey] as String;
    price = map[priceKey] as int;
    cafeId = map[cafeIdKey] as int;
    memo = map[memoKey] as String;
    imageUri = map[imageUriKey] as String;
    drinkDay = DateTime.parse(map[drinkDayKey] as String);
    rate = Rate.fromJsonStr(map[rateKey] as String);
    isFavorite = intToBool(map[isFavoriteKey] as int);
  }

  int uid;
  String productName = '';
  int price = 0;
  DateTime drinkDay;
  Rate rate = Rate();
  int cafeId;
  String memo = '';
  String imageUri;
  bool isFavorite = false;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      uidKey: uid,
      productNameKey: productName,
      priceKey: price,
      cafeIdKey: cafeId,
      memoKey: memo,
      imageUriKey: imageUri,
      // Sqliteで扱えないので扱える型にする
      drinkDayKey: drinkDay.toString(),
      rateKey: rate.toJsonStr(),
      isFavoriteKey: boolToInt(isFavorite),
    };
  }

  @override
  String getImageUri() => imageUri;

  @override
  void setImageUri(String value) => imageUri = value;

  @override
  String getTitle() => productName;

  @override
  void setTitle(String value) => productName = value;

  @override
  String getMessage() => drinkDay.toLocal().toString();
}
