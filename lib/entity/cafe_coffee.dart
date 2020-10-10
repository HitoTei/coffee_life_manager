import 'package:freezed_annotation/freezed_annotation.dart';

part 'cafe_coffee.freezed.dart';
part 'cafe_coffee.g.dart';

@freezed
abstract class CafeCoffee with _$CafeCoffee {
  const factory CafeCoffee({
    @nullable int uid,
    @Default('') String productName,
    @Default(500) int price,
    @nullable DateTime drinkDay,
    @Default([0, 0, 0, 0, 0]) List<int> rate, // 評価
    @nullable int cafeId,
    @Default('') String memo,
    @Default('') String imageUri,
    @Default(false) bool isFavorite,
  }) = _CafeCoffee;

  factory CafeCoffee.fromJson(Map<String, dynamic> json) =>
      _$CafeCoffeeFromJson(json);
}
