import 'package:coffee_life_manager/function/int_bool_parse.dart';
import 'package:coffee_life_manager/model/enums/day_of_the_week.dart';

import '../constant_string.dart';

class Cafe {
  Cafe();

  Cafe.fromMap(Map<String, dynamic> map) {
    uid = map[uidKey] as int;
    cafeName = map[cafeNameKey] as String;
    mapUrl = map[mapUrlKey] as String;
    regularHoliday =
        jsonStrToDayOfTheWeekList(map[regularHolidayKey] as String);

    isFavorite = intToBool(map[isFavoriteKey] as int);
  }

  int uid;
  String cafeName = '';
  String mapUrl = '';
  List<DayOfTheWeek> regularHoliday = [];
  bool isFavorite = false;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      uidKey: uid,
      cafeNameKey: cafeName,
      mapUrlKey: mapUrl,
      // Sqliteで扱えないので扱える型にする
      regularHolidayKey: dayOfTheWeekListToJsonStr(regularHoliday),
      isFavoriteKey: boolToInt(isFavorite),
    };
  }
}
