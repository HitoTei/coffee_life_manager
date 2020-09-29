// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'house_coffee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
HouseCoffee _$HouseCoffeeFromJson(Map<String, dynamic> json) {
  return _HouseCoffee.fromJson(json);
}

/// @nodoc
class _$HouseCoffeeTearOff {
  const _$HouseCoffeeTearOff();

// ignore: unused_element
  _HouseCoffee call(
      {@nullable int uid,
      String beanName = '',
      int numOfCups = 1,
      Grind grind = Grind.middleGrind,
      Drip drip = Drip.paperDrip,
      Roast roast = Roast.mediumRoast,
      @nullable DateTime drinkDay,
      List<int> rate = const [0, 0, 0, 0, 0],
      @nullable int beanId,
      String memo = '',
      String imageUri = '',
      bool isFavorite = false}) {
    return _HouseCoffee(
      uid: uid,
      beanName: beanName,
      numOfCups: numOfCups,
      grind: grind,
      drip: drip,
      roast: roast,
      drinkDay: drinkDay,
      rate: rate,
      beanId: beanId,
      memo: memo,
      imageUri: imageUri,
      isFavorite: isFavorite,
    );
  }

// ignore: unused_element
  HouseCoffee fromJson(Map<String, Object> json) {
    return HouseCoffee.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $HouseCoffee = _$HouseCoffeeTearOff();

/// @nodoc
mixin _$HouseCoffee {
  @nullable
  int get uid;
  String get beanName;
  int get numOfCups;
  Grind get grind;
  Drip get drip;
  Roast get roast;
  @nullable
  DateTime get drinkDay;
  List<int> get rate; // 評価
  @nullable
  int get beanId;
  String get memo;
  String get imageUri;
  bool get isFavorite;

  Map<String, dynamic> toJson();
  $HouseCoffeeCopyWith<HouseCoffee> get copyWith;
}

/// @nodoc
abstract class $HouseCoffeeCopyWith<$Res> {
  factory $HouseCoffeeCopyWith(
          HouseCoffee value, $Res Function(HouseCoffee) then) =
      _$HouseCoffeeCopyWithImpl<$Res>;
  $Res call(
      {@nullable int uid,
      String beanName,
      int numOfCups,
      Grind grind,
      Drip drip,
      Roast roast,
      @nullable DateTime drinkDay,
      List<int> rate,
      @nullable int beanId,
      String memo,
      String imageUri,
      bool isFavorite});
}

/// @nodoc
class _$HouseCoffeeCopyWithImpl<$Res> implements $HouseCoffeeCopyWith<$Res> {
  _$HouseCoffeeCopyWithImpl(this._value, this._then);

  final HouseCoffee _value;
  // ignore: unused_field
  final $Res Function(HouseCoffee) _then;

  @override
  $Res call({
    Object uid = freezed,
    Object beanName = freezed,
    Object numOfCups = freezed,
    Object grind = freezed,
    Object drip = freezed,
    Object roast = freezed,
    Object drinkDay = freezed,
    Object rate = freezed,
    Object beanId = freezed,
    Object memo = freezed,
    Object imageUri = freezed,
    Object isFavorite = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed ? _value.uid : uid as int,
      beanName: beanName == freezed ? _value.beanName : beanName as String,
      numOfCups: numOfCups == freezed ? _value.numOfCups : numOfCups as int,
      grind: grind == freezed ? _value.grind : grind as Grind,
      drip: drip == freezed ? _value.drip : drip as Drip,
      roast: roast == freezed ? _value.roast : roast as Roast,
      drinkDay: drinkDay == freezed ? _value.drinkDay : drinkDay as DateTime,
      rate: rate == freezed ? _value.rate : rate as List<int>,
      beanId: beanId == freezed ? _value.beanId : beanId as int,
      memo: memo == freezed ? _value.memo : memo as String,
      imageUri: imageUri == freezed ? _value.imageUri : imageUri as String,
      isFavorite:
          isFavorite == freezed ? _value.isFavorite : isFavorite as bool,
    ));
  }
}

/// @nodoc
abstract class _$HouseCoffeeCopyWith<$Res>
    implements $HouseCoffeeCopyWith<$Res> {
  factory _$HouseCoffeeCopyWith(
          _HouseCoffee value, $Res Function(_HouseCoffee) then) =
      __$HouseCoffeeCopyWithImpl<$Res>;
  @override
  $Res call(
      {@nullable int uid,
      String beanName,
      int numOfCups,
      Grind grind,
      Drip drip,
      Roast roast,
      @nullable DateTime drinkDay,
      List<int> rate,
      @nullable int beanId,
      String memo,
      String imageUri,
      bool isFavorite});
}

/// @nodoc
class __$HouseCoffeeCopyWithImpl<$Res> extends _$HouseCoffeeCopyWithImpl<$Res>
    implements _$HouseCoffeeCopyWith<$Res> {
  __$HouseCoffeeCopyWithImpl(
      _HouseCoffee _value, $Res Function(_HouseCoffee) _then)
      : super(_value, (v) => _then(v as _HouseCoffee));

  @override
  _HouseCoffee get _value => super._value as _HouseCoffee;

  @override
  $Res call({
    Object uid = freezed,
    Object beanName = freezed,
    Object numOfCups = freezed,
    Object grind = freezed,
    Object drip = freezed,
    Object roast = freezed,
    Object drinkDay = freezed,
    Object rate = freezed,
    Object beanId = freezed,
    Object memo = freezed,
    Object imageUri = freezed,
    Object isFavorite = freezed,
  }) {
    return _then(_HouseCoffee(
      uid: uid == freezed ? _value.uid : uid as int,
      beanName: beanName == freezed ? _value.beanName : beanName as String,
      numOfCups: numOfCups == freezed ? _value.numOfCups : numOfCups as int,
      grind: grind == freezed ? _value.grind : grind as Grind,
      drip: drip == freezed ? _value.drip : drip as Drip,
      roast: roast == freezed ? _value.roast : roast as Roast,
      drinkDay: drinkDay == freezed ? _value.drinkDay : drinkDay as DateTime,
      rate: rate == freezed ? _value.rate : rate as List<int>,
      beanId: beanId == freezed ? _value.beanId : beanId as int,
      memo: memo == freezed ? _value.memo : memo as String,
      imageUri: imageUri == freezed ? _value.imageUri : imageUri as String,
      isFavorite:
          isFavorite == freezed ? _value.isFavorite : isFavorite as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_HouseCoffee implements _HouseCoffee {
  const _$_HouseCoffee(
      {@nullable this.uid,
      this.beanName = '',
      this.numOfCups = 1,
      this.grind = Grind.middleGrind,
      this.drip = Drip.paperDrip,
      this.roast = Roast.mediumRoast,
      @nullable this.drinkDay,
      this.rate = const [0, 0, 0, 0, 0],
      @nullable this.beanId,
      this.memo = '',
      this.imageUri = '',
      this.isFavorite = false})
      : assert(beanName != null),
        assert(numOfCups != null),
        assert(grind != null),
        assert(drip != null),
        assert(roast != null),
        assert(rate != null),
        assert(memo != null),
        assert(imageUri != null),
        assert(isFavorite != null);

  factory _$_HouseCoffee.fromJson(Map<String, dynamic> json) =>
      _$_$_HouseCoffeeFromJson(json);

  @override
  @nullable
  final int uid;
  @JsonKey(defaultValue: '')
  @override
  final String beanName;
  @JsonKey(defaultValue: 1)
  @override
  final int numOfCups;
  @JsonKey(defaultValue: Grind.middleGrind)
  @override
  final Grind grind;
  @JsonKey(defaultValue: Drip.paperDrip)
  @override
  final Drip drip;
  @JsonKey(defaultValue: Roast.mediumRoast)
  @override
  final Roast roast;
  @override
  @nullable
  final DateTime drinkDay;
  @JsonKey(defaultValue: const [0, 0, 0, 0, 0])
  @override
  final List<int> rate;
  @override // 評価
  @nullable
  final int beanId;
  @JsonKey(defaultValue: '')
  @override
  final String memo;
  @JsonKey(defaultValue: '')
  @override
  final String imageUri;
  @JsonKey(defaultValue: false)
  @override
  final bool isFavorite;

  @override
  String toString() {
    return 'HouseCoffee(uid: $uid, beanName: $beanName, numOfCups: $numOfCups, grind: $grind, drip: $drip, roast: $roast, drinkDay: $drinkDay, rate: $rate, beanId: $beanId, memo: $memo, imageUri: $imageUri, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HouseCoffee &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.beanName, beanName) ||
                const DeepCollectionEquality()
                    .equals(other.beanName, beanName)) &&
            (identical(other.numOfCups, numOfCups) ||
                const DeepCollectionEquality()
                    .equals(other.numOfCups, numOfCups)) &&
            (identical(other.grind, grind) ||
                const DeepCollectionEquality().equals(other.grind, grind)) &&
            (identical(other.drip, drip) ||
                const DeepCollectionEquality().equals(other.drip, drip)) &&
            (identical(other.roast, roast) ||
                const DeepCollectionEquality().equals(other.roast, roast)) &&
            (identical(other.drinkDay, drinkDay) ||
                const DeepCollectionEquality()
                    .equals(other.drinkDay, drinkDay)) &&
            (identical(other.rate, rate) ||
                const DeepCollectionEquality().equals(other.rate, rate)) &&
            (identical(other.beanId, beanId) ||
                const DeepCollectionEquality().equals(other.beanId, beanId)) &&
            (identical(other.memo, memo) ||
                const DeepCollectionEquality().equals(other.memo, memo)) &&
            (identical(other.imageUri, imageUri) ||
                const DeepCollectionEquality()
                    .equals(other.imageUri, imageUri)) &&
            (identical(other.isFavorite, isFavorite) ||
                const DeepCollectionEquality()
                    .equals(other.isFavorite, isFavorite)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(beanName) ^
      const DeepCollectionEquality().hash(numOfCups) ^
      const DeepCollectionEquality().hash(grind) ^
      const DeepCollectionEquality().hash(drip) ^
      const DeepCollectionEquality().hash(roast) ^
      const DeepCollectionEquality().hash(drinkDay) ^
      const DeepCollectionEquality().hash(rate) ^
      const DeepCollectionEquality().hash(beanId) ^
      const DeepCollectionEquality().hash(memo) ^
      const DeepCollectionEquality().hash(imageUri) ^
      const DeepCollectionEquality().hash(isFavorite);

  @override
  _$HouseCoffeeCopyWith<_HouseCoffee> get copyWith =>
      __$HouseCoffeeCopyWithImpl<_HouseCoffee>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_HouseCoffeeToJson(this);
  }
}

abstract class _HouseCoffee implements HouseCoffee {
  const factory _HouseCoffee(
      {@nullable int uid,
      String beanName,
      int numOfCups,
      Grind grind,
      Drip drip,
      Roast roast,
      @nullable DateTime drinkDay,
      List<int> rate,
      @nullable int beanId,
      String memo,
      String imageUri,
      bool isFavorite}) = _$_HouseCoffee;

  factory _HouseCoffee.fromJson(Map<String, dynamic> json) =
      _$_HouseCoffee.fromJson;

  @override
  @nullable
  int get uid;
  @override
  String get beanName;
  @override
  int get numOfCups;
  @override
  Grind get grind;
  @override
  Drip get drip;
  @override
  Roast get roast;
  @override
  @nullable
  DateTime get drinkDay;
  @override
  List<int> get rate;
  @override // 評価
  @nullable
  int get beanId;
  @override
  String get memo;
  @override
  String get imageUri;
  @override
  bool get isFavorite;
  @override
  _$HouseCoffeeCopyWith<_HouseCoffee> get copyWith;
}
