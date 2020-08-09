import '../constant_string.dart';

class CafeCoffee {
  CafeCoffee();
  CafeCoffee.fromMap(Map<String, dynamic> map) {
    uid = map[uidKey] as int;
    productName = map[productNameKey] as String;
    price = map[priceKey] as int;
    drinkDay = map[drinkDayKey] as DateTime;
    rateId = map[rateIdKey] as int;
    cafeId = map[cafeIdKey] as int;
    memo = map[memoKey] as String;
    isFavorite = map[isFavoriteKey] as bool;
  }
  int uid;
  String productName = '';
  int price;
  DateTime drinkDay;
  int rateId;
  int cafeId;
  String memo = '';
  bool isFavorite;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      uidKey: uid,
      productNameKey: productName,
      priceKey: price,
      drinkDayKey: drinkDay,
      rateIdKey: rateId,
      cafeIdKey: cafeId,
      memoKey: memo,
      isFavoriteKey: isFavorite,
    };
  }
}
