import 'dart:convert';

enum DayOfTheWeek {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  publicHoliday
}

const dayOfTheWeekStr = [
  '日',
  '月',
  '火',
  '水',
  '木',
  '金',
  '土',
  '祝日',
];

String dayOfTheWeekListToJsonStr(List<DayOfTheWeek> list) {
  return jsonEncode(list.map((e) => e.index).toList());
}

List<DayOfTheWeek> jsonStrToDayOfTheWeekList(String jsonStr) {
  return (jsonDecode(jsonStr) as Iterable)
      .map((dynamic e) => DayOfTheWeek.values[e as int])
      .toList();
}
