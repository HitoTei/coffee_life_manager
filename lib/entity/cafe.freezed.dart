// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'cafe.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Cafe _$CafeFromJson(Map<String, dynamic> json) {
  return _Cafe.fromJson(json);
}

/// @nodoc
class _$CafeTearOff {
  const _$CafeTearOff();

// ignore: unused_element
  _Cafe call(
      {@nullable int uid,
      String cafeName = '',
      String mapUrl = '',
      String imageUri = '',
      List<DayOfTheWeek> regularHoliday = const <DayOfTheWeek>[],
      List<int> startTime = const [0, 0],
      List<int> endTime = const [0, 0],
      bool isFavorite = false}) {
    return _Cafe(
      uid: uid,
      cafeName: cafeName,
      mapUrl: mapUrl,
      imageUri: imageUri,
      regularHoliday: regularHoliday,
      startTime: startTime,
      endTime: endTime,
      isFavorite: isFavorite,
    );
  }

// ignore: unused_element
  Cafe fromJson(Map<String, Object> json) {
    return Cafe.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Cafe = _$CafeTearOff();

/// @nodoc
mixin _$Cafe {
  @nullable
  int get uid;
  String get cafeName;
  String get mapUrl;
  String get imageUri;
  List<DayOfTheWeek> get regularHoliday;
  List<int> get startTime;
  List<int> get endTime; // 営業時間
  bool get isFavorite;

  Map<String, dynamic> toJson();
  $CafeCopyWith<Cafe> get copyWith;
}

/// @nodoc
abstract class $CafeCopyWith<$Res> {
  factory $CafeCopyWith(Cafe value, $Res Function(Cafe) then) =
      _$CafeCopyWithImpl<$Res>;
  $Res call(
      {@nullable int uid,
      String cafeName,
      String mapUrl,
      String imageUri,
      List<DayOfTheWeek> regularHoliday,
      List<int> startTime,
      List<int> endTime,
      bool isFavorite});
}

/// @nodoc
class _$CafeCopyWithImpl<$Res> implements $CafeCopyWith<$Res> {
  _$CafeCopyWithImpl(this._value, this._then);

  final Cafe _value;
  // ignore: unused_field
  final $Res Function(Cafe) _then;

  @override
  $Res call({
    Object uid = freezed,
    Object cafeName = freezed,
    Object mapUrl = freezed,
    Object imageUri = freezed,
    Object regularHoliday = freezed,
    Object startTime = freezed,
    Object endTime = freezed,
    Object isFavorite = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed ? _value.uid : uid as int,
      cafeName: cafeName == freezed ? _value.cafeName : cafeName as String,
      mapUrl: mapUrl == freezed ? _value.mapUrl : mapUrl as String,
      imageUri: imageUri == freezed ? _value.imageUri : imageUri as String,
      regularHoliday: regularHoliday == freezed
          ? _value.regularHoliday
          : regularHoliday as List<DayOfTheWeek>,
      startTime:
          startTime == freezed ? _value.startTime : startTime as List<int>,
      endTime: endTime == freezed ? _value.endTime : endTime as List<int>,
      isFavorite:
          isFavorite == freezed ? _value.isFavorite : isFavorite as bool,
    ));
  }
}

/// @nodoc
abstract class _$CafeCopyWith<$Res> implements $CafeCopyWith<$Res> {
  factory _$CafeCopyWith(_Cafe value, $Res Function(_Cafe) then) =
      __$CafeCopyWithImpl<$Res>;
  @override
  $Res call(
      {@nullable int uid,
      String cafeName,
      String mapUrl,
      String imageUri,
      List<DayOfTheWeek> regularHoliday,
      List<int> startTime,
      List<int> endTime,
      bool isFavorite});
}

/// @nodoc
class __$CafeCopyWithImpl<$Res> extends _$CafeCopyWithImpl<$Res>
    implements _$CafeCopyWith<$Res> {
  __$CafeCopyWithImpl(_Cafe _value, $Res Function(_Cafe) _then)
      : super(_value, (v) => _then(v as _Cafe));

  @override
  _Cafe get _value => super._value as _Cafe;

  @override
  $Res call({
    Object uid = freezed,
    Object cafeName = freezed,
    Object mapUrl = freezed,
    Object imageUri = freezed,
    Object regularHoliday = freezed,
    Object startTime = freezed,
    Object endTime = freezed,
    Object isFavorite = freezed,
  }) {
    return _then(_Cafe(
      uid: uid == freezed ? _value.uid : uid as int,
      cafeName: cafeName == freezed ? _value.cafeName : cafeName as String,
      mapUrl: mapUrl == freezed ? _value.mapUrl : mapUrl as String,
      imageUri: imageUri == freezed ? _value.imageUri : imageUri as String,
      regularHoliday: regularHoliday == freezed
          ? _value.regularHoliday
          : regularHoliday as List<DayOfTheWeek>,
      startTime:
          startTime == freezed ? _value.startTime : startTime as List<int>,
      endTime: endTime == freezed ? _value.endTime : endTime as List<int>,
      isFavorite:
          isFavorite == freezed ? _value.isFavorite : isFavorite as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Cafe implements _Cafe {
  const _$_Cafe(
      {@nullable this.uid,
      this.cafeName = '',
      this.mapUrl = '',
      this.imageUri = '',
      this.regularHoliday = const <DayOfTheWeek>[],
      this.startTime = const [0, 0],
      this.endTime = const [0, 0],
      this.isFavorite = false})
      : assert(cafeName != null),
        assert(mapUrl != null),
        assert(imageUri != null),
        assert(regularHoliday != null),
        assert(startTime != null),
        assert(endTime != null),
        assert(isFavorite != null);

  factory _$_Cafe.fromJson(Map<String, dynamic> json) =>
      _$_$_CafeFromJson(json);

  @override
  @nullable
  final int uid;
  @JsonKey(defaultValue: '')
  @override
  final String cafeName;
  @JsonKey(defaultValue: '')
  @override
  final String mapUrl;
  @JsonKey(defaultValue: '')
  @override
  final String imageUri;
  @JsonKey(defaultValue: const <DayOfTheWeek>[])
  @override
  final List<DayOfTheWeek> regularHoliday;
  @JsonKey(defaultValue: const [0, 0])
  @override
  final List<int> startTime;
  @JsonKey(defaultValue: const [0, 0])
  @override
  final List<int> endTime;
  @JsonKey(defaultValue: false)
  @override // 営業時間
  final bool isFavorite;

  @override
  String toString() {
    return 'Cafe(uid: $uid, cafeName: $cafeName, mapUrl: $mapUrl, imageUri: $imageUri, regularHoliday: $regularHoliday, startTime: $startTime, endTime: $endTime, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Cafe &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.cafeName, cafeName) ||
                const DeepCollectionEquality()
                    .equals(other.cafeName, cafeName)) &&
            (identical(other.mapUrl, mapUrl) ||
                const DeepCollectionEquality().equals(other.mapUrl, mapUrl)) &&
            (identical(other.imageUri, imageUri) ||
                const DeepCollectionEquality()
                    .equals(other.imageUri, imageUri)) &&
            (identical(other.regularHoliday, regularHoliday) ||
                const DeepCollectionEquality()
                    .equals(other.regularHoliday, regularHoliday)) &&
            (identical(other.startTime, startTime) ||
                const DeepCollectionEquality()
                    .equals(other.startTime, startTime)) &&
            (identical(other.endTime, endTime) ||
                const DeepCollectionEquality()
                    .equals(other.endTime, endTime)) &&
            (identical(other.isFavorite, isFavorite) ||
                const DeepCollectionEquality()
                    .equals(other.isFavorite, isFavorite)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(cafeName) ^
      const DeepCollectionEquality().hash(mapUrl) ^
      const DeepCollectionEquality().hash(imageUri) ^
      const DeepCollectionEquality().hash(regularHoliday) ^
      const DeepCollectionEquality().hash(startTime) ^
      const DeepCollectionEquality().hash(endTime) ^
      const DeepCollectionEquality().hash(isFavorite);

  @override
  _$CafeCopyWith<_Cafe> get copyWith =>
      __$CafeCopyWithImpl<_Cafe>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CafeToJson(this);
  }
}

abstract class _Cafe implements Cafe {
  const factory _Cafe(
      {@nullable int uid,
      String cafeName,
      String mapUrl,
      String imageUri,
      List<DayOfTheWeek> regularHoliday,
      List<int> startTime,
      List<int> endTime,
      bool isFavorite}) = _$_Cafe;

  factory _Cafe.fromJson(Map<String, dynamic> json) = _$_Cafe.fromJson;

  @override
  @nullable
  int get uid;
  @override
  String get cafeName;
  @override
  String get mapUrl;
  @override
  String get imageUri;
  @override
  List<DayOfTheWeek> get regularHoliday;
  @override
  List<int> get startTime;
  @override
  List<int> get endTime;
  @override // 営業時間
  bool get isFavorite;
  @override
  _$CafeCopyWith<_Cafe> get copyWith;
}
