// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cafe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Cafe _$_$_CafeFromJson(Map<String, dynamic> json) {
  return _$_Cafe(
    uid: json['uid'] as int,
    cafeName: json['cafeName'] as String ?? '',
    mapUrl: json['mapUrl'] as String ?? '',
    imageUri: json['imageUri'] as String ?? '',
    regularHoliday: (json['regularHoliday'] as List)
            ?.map((dynamic e) => _$enumDecodeNullable(_$DayOfTheWeekEnumMap, e))
            ?.toList() ??
        [],
    startTime:
        (json['startTime'] as List)?.map((dynamic e) => e as int)?.toList() ??
            [0, 0],
    endTime:
        (json['endTime'] as List)?.map((dynamic e) => e as int)?.toList() ??
            [0, 0],
    isFavorite: json['isFavorite'] as bool ?? false,
  );
}

Map<String, dynamic> _$_$_CafeToJson(_$_Cafe instance) => <String, dynamic>{
      'uid': instance.uid,
      'cafeName': instance.cafeName,
      'mapUrl': instance.mapUrl,
      'imageUri': instance.imageUri,
      'regularHoliday': instance.regularHoliday
          ?.map((e) => _$DayOfTheWeekEnumMap[e])
          ?.toList(),
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'isFavorite': instance.isFavorite,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$DayOfTheWeekEnumMap = {
  DayOfTheWeek.sunday: 'sunday',
  DayOfTheWeek.monday: 'monday',
  DayOfTheWeek.tuesday: 'tuesday',
  DayOfTheWeek.wednesday: 'wednesday',
  DayOfTheWeek.thursday: 'thursday',
  DayOfTheWeek.friday: 'friday',
  DayOfTheWeek.saturday: 'saturday',
  DayOfTheWeek.publicHoliday: 'publicHoliday',
};
