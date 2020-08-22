import 'package:coffee_life_manager/model/cafe.dart';
import 'package:coffee_life_manager/model/enums/day_of_the_week.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/cafe_dao.dart';
import 'package:flutter/cupertino.dart';

class CafeDetailPageViewModel {
  CafeDetailPageViewModel(this.cafe, this.dao)
      : isFavorite = ValueNotifier(cafe.isFavorite),
        regularHoliday = ValueNotifier(cafe.regularHoliday),
        mapUrl = ValueNotifier(cafe.mapUrl);

  final Cafe cafe;
  final CafeDao dao;

  void onInitState() {
    dao.insert(cafe).then((value) => cafe.uid = value);
  }

  void onDispose() {
    dao.update(cafe);
  }

  ValueNotifier<bool> isFavorite;
  ValueNotifier<List<DayOfTheWeek>> regularHoliday;
  ValueNotifier<String> mapUrl;

  void share() {}
}
