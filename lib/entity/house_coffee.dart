import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/drip.dart';
import 'enums/grind.dart';
import 'enums/roast.dart';

part 'house_coffee.freezed.dart';
part 'house_coffee.g.dart';

@freezed
abstract class HouseCoffee with _$HouseCoffee {
  const factory HouseCoffee({
    @nullable int uid,
    @Default('') String beanName,
    @Default(1) int numOfCups,
    @Default(Grind.middleGrind) Grind grind,
    @Default(Drip.paperDrip) Drip drip,
    @Default(Roast.mediumRoast) Roast roast,
    @nullable DateTime drinkDay,
    @Default([0, 0, 0, 0, 0]) List<int> rate, // 評価
    @nullable int beanId,
    @Default('') String memo,
    @Default('') String imageUri,
    @Default(false) bool isFavorite,
  }) = _HouseCoffee;

  factory HouseCoffee.fromJson(Map<String, dynamic> json) =>
      _$HouseCoffeeFromJson(json);
}
