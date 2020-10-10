import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/roast.dart';

part 'bean.freezed.dart';
part 'bean.g.dart';

@freezed
abstract class Bean with _$Bean {
  const factory Bean(
      {@nullable int uid,
      @Default('') String beanName,
      @Default(200) int remainingAmount, // 残量
      @Default(200) int firstAmount, // 最初の量
      @Default(10) int oneCupPerGram, // 一杯当たりの豆の量
      @Default(Roast.mediumRoast) Roast roast, // 焙煎
      @nullable DateTime freshnessDate, // 賞味期限
      @nullable DateTime openTime, // 開封日時
      @Default(1000) int price, // 値段
      @Default([0, 0, 0, 0, 0]) List<int> rate, // 評価
      @nullable int cafeId,
      @Default('') String memo, // メモ
      @Default('') String imageUri,
      @Default(false) bool isFavorite}) = _Bean;

  factory Bean.fromJson(Map<String, dynamic> json) => _$BeanFromJson(json);
}
