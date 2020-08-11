import 'dart:convert';

enum DayOfTheWeek {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
}

String dayOfTheWeekListToJsonStr(List<DayOfTheWeek> list) {
  return jsonEncode(list.map((e) => e.index).toList());
}

List<DayOfTheWeek> jsonStrToDayOfTheWeekList(String jsonStr) {
  return (jsonDecode(jsonStr) as Iterable)
      .map((dynamic e) => DayOfTheWeek.values[e as int])
      .toList();
}
