// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Bean _$_$_BeanFromJson(Map<String, dynamic> json) {
  return _$_Bean(
    uid: json['uid'] as int,
    beanName: json['beanName'] as String ?? '',
    remainingAmount: json['remainingAmount'] as int ?? 0,
    firstAmount: json['firstAmount'] as int ?? 0,
    oneCupPerGram: json['oneCupPerGram'] as int ?? 0,
    roast: _$enumDecodeNullable(_$RoastEnumMap, json['roast']) ??
        Roast.mediumRoast,
    freshnessDate: json['freshnessDate'] == null
        ? null
        : DateTime.parse(json['freshnessDate'] as String),
    openTime: json['openTime'] == null
        ? null
        : DateTime.parse(json['openTime'] as String),
    price: json['price'] as int ?? 0,
    rate: (json['rate'] as List)?.map((dynamic e) => e as int)?.toList() ??
        [0, 0, 0, 0, 0],
    cafeId: json['cafeId'] as int,
    memo: json['memo'] as String ?? '',
    imageUri: json['imageUri'] as String ?? '',
    isFavorite: json['isFavorite'] as bool ?? false,
  );
}

Map<String, dynamic> _$_$_BeanToJson(_$_Bean instance) => <String, dynamic>{
      'uid': instance.uid,
      'beanName': instance.beanName,
      'remainingAmount': instance.remainingAmount,
      'firstAmount': instance.firstAmount,
      'oneCupPerGram': instance.oneCupPerGram,
      'roast': _$RoastEnumMap[instance.roast],
      'freshnessDate': instance.freshnessDate?.toIso8601String(),
      'openTime': instance.openTime?.toIso8601String(),
      'price': instance.price,
      'rate': instance.rate,
      'cafeId': instance.cafeId,
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
