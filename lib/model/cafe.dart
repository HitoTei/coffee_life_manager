import 'package:coffee_life_manager/function/int_bool_parse.dart';
import 'package:coffee_life_manager/model/enums/day_of_the_week.dart';
import 'package:coffee_life_manager/model/interface/image_card_information.dart';
import 'package:flutter/material.dart';

import '../constant_string.dart';

class Cafe implements ImageCardInformation {
  Cafe();

  Cafe.fromMap(Map<String, dynamic> map) {
    uid = map[uidKey] as int;
    cafeName = map[cafeNameKey] as String;
    mapUrl = map[mapUrlKey] as String;
    imageUri = map[imageUriKey] as String;

    startTime = _parseToTimeOfDay(map[startTimeKey] as String);
    endTime = _parseToTimeOfDay(map[endTimeKey] as String);
    regularHoliday =
        jsonStrToDayOfTheWeekList(map[regularHolidayKey] as String);
    isFavorite = intToBool(map[isFavoriteKey] as int);
  }

  int uid;
  String cafeName = '';
  String mapUrl = '';
  String imageUri;
  List<DayOfTheWeek> regularHoliday = [];
  TimeOfDay startTime = const TimeOfDay(hour: 8, minute: 0),
      endTime = const TimeOfDay(hour: 18, minute: 0); // 営業時間
  bool isFavorite = false;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      uidKey: uid,
      cafeNameKey: cafeName.toString(),
      mapUrlKey: mapUrl.toString(),
      imageUriKey: imageUri,
      // Sqliteで扱えないので扱える型にする

      startTimeKey: '${startTime.hour} ${startTime.minute}',
      endTimeKey: '${endTime.hour} ${endTime.minute}',
      regularHolidayKey: dayOfTheWeekListToJsonStr(regularHoliday),
      isFavoriteKey: boolToInt(isFavorite),
    };
  }

  static TimeOfDay _parseToTimeOfDay(String str) {
    final list = str.split(' ');
    final hour = int.parse(list[0]);
    final minute = int.parse(list[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  String getImageUri() => imageUri;

  @override
  void setImageUri(String value) => imageUri = value;

  @override
  String getTitle() => cafeName;

  @override
  void setTitle(String value) => cafeName = value;

  @override
  String getMessage() => null;
}
