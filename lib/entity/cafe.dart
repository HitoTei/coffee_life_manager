import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/day_of_the_week.dart';

part 'cafe.freezed.dart';
part 'cafe.g.dart';

@freezed
abstract class Cafe with _$Cafe {
  const factory Cafe({
    @nullable int uid,
    @Default('') String cafeName,
    @Default('') String mapUrl,
    @Default('') String imageUri,
    @Default(<DayOfTheWeek>[]) List<DayOfTheWeek> regularHoliday,
    @Default([0, 0]) List<int> startTime,
    @Default([0, 0]) List<int> endTime, // 営業時間
    @Default(false) bool isFavorite,
    @Default('') String memo,
  }) = _Cafe;

  factory Cafe.fromJson(Map<String, dynamic> json) => _$CafeFromJson(json);
}

extension ParseString on String {
  TimeOfDay toTimeOfDay(String str) {
    final list = str.split(' ');
    final hour = int.parse(list[0]);
    final minute = int.parse(list[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
