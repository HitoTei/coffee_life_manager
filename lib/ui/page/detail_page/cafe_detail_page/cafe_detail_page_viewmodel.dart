import 'package:coffee_life_manager/model/cafe.dart';
import 'package:coffee_life_manager/model/enums/day_of_the_week.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/cafe_dao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CafeDetailPageViewModel {
  CafeDetailPageViewModel(this.cafe, this.dao)
      : isFavorite = ValueNotifier(cafe.isFavorite),
        regularHoliday = ValueNotifier(cafe.regularHoliday),
        mapUrl = ValueNotifier(cafe.mapUrl),
        startTime = ValueNotifier(cafe.startTime),
        endTime = ValueNotifier(cafe.endTime);

  final Cafe cafe;
  final CafeDao dao;

  void onInitState() {
    dao.insert(cafe).then((value) => cafe.uid = value);
  }

  Future<void> onDispose() {
    return dao.update(cafe);
  }

  final ValueNotifier<bool> isFavorite;
  final ValueNotifier<List<DayOfTheWeek>> regularHoliday;
  final ValueNotifier<String> mapUrl;
  final ValueNotifier<TimeOfDay> startTime;
  final ValueNotifier<TimeOfDay> endTime;

  void isFavoriteChanged(bool val) {
    isFavorite.value = val;
    cafe.isFavorite = val;
  }

  void regularHolidayChanged(List<DayOfTheWeek> val) {
    regularHoliday.value = val;
    cafe.regularHoliday = val;
  }

  void mapUrlChanged(String val) {
    mapUrl.value = val;
    cafe.mapUrl = val;
  }

  void startTimeChanged(TimeOfDay val) {
    startTime.value = val;
    cafe.startTime = val;
  }

  void endTimeChanged(TimeOfDay val) {
    endTime.value = val;
    cafe.endTime = val;
  }

  void share() {}
}
