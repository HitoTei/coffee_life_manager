// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cafe_coffee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CafeCoffee _$_$_CafeCoffeeFromJson(Map<String, dynamic> json) {
  return _$_CafeCoffee(
    uid: json['uid'] as int,
    productName: json['productName'] as String ?? '',
    price: json['price'] as int ?? 500,
    drinkDay: json['drinkDay'] == null
        ? null
        : DateTime.parse(json['drinkDay'] as String),
    rate: (json['rate'] as List)?.map((dynamic e) => e as int)?.toList() ??
        [0, 0, 0, 0, 0],
    cafeId: json['cafeId'] as int,
    memo: json['memo'] as String ?? '',
    imageUri: json['imageUri'] as String ?? '',
    isFavorite: json['isFavorite'] as bool ?? false,
  );
}

Map<String, dynamic> _$_$_CafeCoffeeToJson(_$_CafeCoffee instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'productName': instance.productName,
      'price': instance.price,
      'drinkDay': instance.drinkDay?.toIso8601String(),
      'rate': instance.rate,
      'cafeId': instance.cafeId,
      'memo': instance.memo,
      'imageUri': instance.imageUri,
      'isFavorite': instance.isFavorite,
    };
