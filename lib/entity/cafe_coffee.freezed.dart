// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'cafe_coffee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
CafeCoffee _$CafeCoffeeFromJson(Map<String, dynamic> json) {
  return _CafeCoffee.fromJson(json);
}

/// @nodoc
class _$CafeCoffeeTearOff {
  const _$CafeCoffeeTearOff();

// ignore: unused_element
  _CafeCoffee call(
      {@nullable int uid,
      String productName = '',
      int price = 0,
      @nullable DateTime drinkDay,
      List<int> rate = const [0, 0, 0, 0, 0],
      @nullable int cafeId,
      String memo = '',
      String imageUri = '',
      bool isFavorite = false}) {
    return _CafeCoffee(
      uid: uid,
      productName: productName,
      price: price,
      drinkDay: drinkDay,
      rate: rate,
      cafeId: cafeId,
      memo: memo,
      imageUri: imageUri,
      isFavorite: isFavorite,
    );
  }

// ignore: unused_element
  CafeCoffee fromJson(Map<String, Object> json) {
    return CafeCoffee.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $CafeCoffee = _$CafeCoffeeTearOff();

/// @nodoc
mixin _$CafeCoffee {
  @nullable
  int get uid;
  String get productName;
  int get price;
  @nullable
  DateTime get drinkDay;
  List<int> get rate; // 評価
  @nullable
  int get cafeId;
  String get memo;
  String get imageUri;
  bool get isFavorite;

  Map<String, dynamic> toJson();
  $CafeCoffeeCopyWith<CafeCoffee> get copyWith;
}

/// @nodoc
abstract class $CafeCoffeeCopyWith<$Res> {
  factory $CafeCoffeeCopyWith(
          CafeCoffee value, $Res Function(CafeCoffee) then) =
      _$CafeCoffeeCopyWithImpl<$Res>;
  $Res call(
      {@nullable int uid,
      String productName,
      int price,
      @nullable DateTime drinkDay,
      List<int> rate,
      @nullable int cafeId,
      String memo,
      String imageUri,
      bool isFavorite});
}

/// @nodoc
class _$CafeCoffeeCopyWithImpl<$Res> implements $CafeCoffeeCopyWith<$Res> {
  _$CafeCoffeeCopyWithImpl(this._value, this._then);

  final CafeCoffee _value;
  // ignore: unused_field
  final $Res Function(CafeCoffee) _then;

  @override
  $Res call({
    Object uid = freezed,
    Object productName = freezed,
    Object price = freezed,
    Object drinkDay = freezed,
    Object rate = freezed,
    Object cafeId = freezed,
    Object memo = freezed,
    Object imageUri = freezed,
    Object isFavorite = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed ? _value.uid : uid as int,
      productName:
          productName == freezed ? _value.productName : productName as String,
      price: price == freezed ? _value.price : price as int,
      drinkDay: drinkDay == freezed ? _value.drinkDay : drinkDay as DateTime,
      rate: rate == freezed ? _value.rate : rate as List<int>,
      cafeId: cafeId == freezed ? _value.cafeId : cafeId as int,
      memo: memo == freezed ? _value.memo : memo as String,
      imageUri: imageUri == freezed ? _value.imageUri : imageUri as String,
      isFavorite:
          isFavorite == freezed ? _value.isFavorite : isFavorite as bool,
    ));
  }
}

/// @nodoc
abstract class _$CafeCoffeeCopyWith<$Res> implements $CafeCoffeeCopyWith<$Res> {
  factory _$CafeCoffeeCopyWith(
          _CafeCoffee value, $Res Function(_CafeCoffee) then) =
      __$CafeCoffeeCopyWithImpl<$Res>;
  @override
  $Res call(
      {@nullable int uid,
      String productName,
      int price,
      @nullable DateTime drinkDay,
      List<int> rate,
      @nullable int cafeId,
      String memo,
      String imageUri,
      bool isFavorite});
}

/// @nodoc
class __$CafeCoffeeCopyWithImpl<$Res> extends _$CafeCoffeeCopyWithImpl<$Res>
    implements _$CafeCoffeeCopyWith<$Res> {
  __$CafeCoffeeCopyWithImpl(
      _CafeCoffee _value, $Res Function(_CafeCoffee) _then)
      : super(_value, (v) => _then(v as _CafeCoffee));

  @override
  _CafeCoffee get _value => super._value as _CafeCoffee;

  @override
  $Res call({
    Object uid = freezed,
    Object productName = freezed,
    Object price = freezed,
    Object drinkDay = freezed,
    Object rate = freezed,
    Object cafeId = freezed,
    Object memo = freezed,
    Object imageUri = freezed,
    Object isFavorite = freezed,
  }) {
    return _then(_CafeCoffee(
      uid: uid == freezed ? _value.uid : uid as int,
      productName:
          productName == freezed ? _value.productName : productName as String,
      price: price == freezed ? _value.price : price as int,
      drinkDay: drinkDay == freezed ? _value.drinkDay : drinkDay as DateTime,
      rate: rate == freezed ? _value.rate : rate as List<int>,
      cafeId: cafeId == freezed ? _value.cafeId : cafeId as int,
      memo: memo == freezed ? _value.memo : memo as String,
      imageUri: imageUri == freezed ? _value.imageUri : imageUri as String,
      isFavorite:
          isFavorite == freezed ? _value.isFavorite : isFavorite as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_CafeCoffee implements _CafeCoffee {
  const _$_CafeCoffee(
      {@nullable this.uid,
      this.productName = '',
      this.price = 0,
      @nullable this.drinkDay,
      this.rate = const [0, 0, 0, 0, 0],
      @nullable this.cafeId,
      this.memo = '',
      this.imageUri = '',
      this.isFavorite = false})
      : assert(productName != null),
        assert(price != null),
        assert(rate != null),
        assert(memo != null),
        assert(imageUri != null),
        assert(isFavorite != null);

  factory _$_CafeCoffee.fromJson(Map<String, dynamic> json) =>
      _$_$_CafeCoffeeFromJson(json);

  @override
  @nullable
  final int uid;
  @JsonKey(defaultValue: '')
  @override
  final String productName;
  @JsonKey(defaultValue: 0)
  @override
  final int price;
  @override
  @nullable
  final DateTime drinkDay;
  @JsonKey(defaultValue: const [0, 0, 0, 0, 0])
  @override
  final List<int> rate;
  @override // 評価
  @nullable
  final int cafeId;
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
    return 'CafeCoffee(uid: $uid, productName: $productName, price: $price, drinkDay: $drinkDay, rate: $rate, cafeId: $cafeId, memo: $memo, imageUri: $imageUri, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CafeCoffee &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.productName, productName) ||
                const DeepCollectionEquality()
                    .equals(other.productName, productName)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.drinkDay, drinkDay) ||
                const DeepCollectionEquality()
                    .equals(other.drinkDay, drinkDay)) &&
            (identical(other.rate, rate) ||
                const DeepCollectionEquality().equals(other.rate, rate)) &&
            (identical(other.cafeId, cafeId) ||
                const DeepCollectionEquality().equals(other.cafeId, cafeId)) &&
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
      const DeepCollectionEquality().hash(productName) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(drinkDay) ^
      const DeepCollectionEquality().hash(rate) ^
      const DeepCollectionEquality().hash(cafeId) ^
      const DeepCollectionEquality().hash(memo) ^
      const DeepCollectionEquality().hash(imageUri) ^
      const DeepCollectionEquality().hash(isFavorite);

  @override
  _$CafeCoffeeCopyWith<_CafeCoffee> get copyWith =>
      __$CafeCoffeeCopyWithImpl<_CafeCoffee>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CafeCoffeeToJson(this);
  }
}

abstract class _CafeCoffee implements CafeCoffee {
  const factory _CafeCoffee(
      {@nullable int uid,
      String productName,
      int price,
      @nullable DateTime drinkDay,
      List<int> rate,
      @nullable int cafeId,
      String memo,
      String imageUri,
      bool isFavorite}) = _$_CafeCoffee;

  factory _CafeCoffee.fromJson(Map<String, dynamic> json) =
      _$_CafeCoffee.fromJson;

  @override
  @nullable
  int get uid;
  @override
  String get productName;
  @override
  int get price;
  @override
  @nullable
  DateTime get drinkDay;
  @override
  List<int> get rate;
  @override // 評価
  @nullable
  int get cafeId;
  @override
  String get memo;
  @override
  String get imageUri;
  @override
  bool get isFavorite;
  @override
  _$CafeCoffeeCopyWith<_CafeCoffee> get copyWith;
}
