import 'package:coffee_life_manager/model/enums/day_of_the_week.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'day of the week encoding and decording test',
    () {
      final list = [
        DayOfTheWeek.friday,
        DayOfTheWeek.monday,
        DayOfTheWeek.sunday
      ];

      final jsonStr = dayOfTheWeekListToJsonStr(list);
      final list2 = jsonStrToDayOfTheWeekList(jsonStr);
      expect(list, list2);

      final jsonStr2 = dayOfTheWeekListToJsonStr(list2);
      final list3 = jsonStrToDayOfTheWeekList(jsonStr2);
      expect(list, list3);
      expect(list2.toString() == list3.toString(), true);
    },
  );
}
