// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_coffee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HouseCoffee _$_$_HouseCoffeeFromJson(Map<String, dynamic> json) {
  return _$_HouseCoffee(
    uid: json['uid'] as int,
    beanName: json['beanName'] as String ?? '',
    numOfCups: json['numOfCups'] as int ?? 1,
    grind: _$enumDecodeNullable(_$GrindEnumMap, json['grind']) ??
        Grind.middleGrind,
    drip: _$enumDecodeNullable(_$DripEnumMap, json['drip']) ?? Drip.paperDrip,
    roast: _$enumDecodeNullable(_$RoastEnumMap, json['roast']) ??
        Roast.mediumRoast,
    drinkDay: json['drinkDay'] == null
        ? null
        : DateTime.parse(json['drinkDay'] as String),
    rate: (json['rate'] as List)?.map((dynamic e) => e as int)?.toList() ??
        [0, 0, 0, 0, 0],
    beanId: json['beanId'] as int,
    memo: json['memo'] as String ?? '',
    imageUri: json['imageUri'] as String ?? '',
    isFavorite: json['isFavorite'] as bool ?? false,
  );
}

Map<String, dynamic> _$_$_HouseCoffeeToJson(_$_HouseCoffee instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'beanName': instance.beanName,
      'numOfCups': instance.numOfCups,
      'grind': _$GrindEnumMap[instance.grind],
      'drip': _$DripEnumMap[instance.drip],
      'roast': _$RoastEnumMap[instance.roast],
      'drinkDay': instance.drinkDay?.toIso8601String(),
      'rate': instance.rate,
      'beanId': instance.beanId,
      'memo': instance.memo,
      'imageUri': instance.imageUri,
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

const _$GrindEnumMap = {
  Grind.positionCoarselyGrind: 'positionCoarselyGrind',
  Grind.coarselyGrind: 'coarselyGrind',
  Grind.middleGrind: 'middleGrind',
  Grind.fineGrind: 'fineGrind',
  Grind.extraFineGrind: 'extraFineGrind',
};

const _$DripEnumMap = {
  Drip.paperDrip: 'paperDrip',
  Drip.nelDrip: 'nelDrip',
  Drip.aeroPress: 'aeroPress',
  Drip.coffeeMaker: 'coffeeMaker',
  Drip.waterDrip: 'waterDrip',
  Drip.pod: 'pod',
  Drip.frenchPress: 'frenchPress',
  Drip.percolator: 'percolator',
  Drip.siphon: 'siphon',
  Drip.espresso: 'espresso',
};

const _$RoastEnumMap = {
  Roast.lightRoast: 'lightRoast',
  Roast.cinnamonRoast: 'cinnamonRoast',
  Roast.mediumRoast: 'mediumRoast',
  Roast.highRoast: 'highRoast',
  Roast.cityRoast: 'cityRoast',
  Roast.fullCityRoast: 'fullCityRoast',
  Roast.frenchRoast: 'frenchRoast',
  Roast.italianRoast: 'italianRoast',
};
