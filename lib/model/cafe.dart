import '../constant_string.dart';

class Cafe {
  Cafe();
  Cafe.fromMap(Map<String, dynamic> map) {
    uid = map[uidKey] as int;
    cafeName = map[cafeNameKey] as String;
    mapUrl = map[mapUrlKey] as String;
    regularHoliday = map[regularHolidayKey] as String;
    isFavorite = map[isFavoriteKey] as bool;
  }
  int uid;
  String cafeName = '';
  String mapUrl = '';
  String regularHoliday = '';
  bool isFavorite;
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      uidKey: uid,
      cafeNameKey: cafeName,
      mapUrlKey: mapUrl,
      regularHolidayKey: regularHoliday,
      isFavoriteKey: isFavorite,
    };
  }
}
