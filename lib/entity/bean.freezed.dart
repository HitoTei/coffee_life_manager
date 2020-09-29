// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'bean.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Bean _$BeanFromJson(Map<String, dynamic> json) {
  return _Bean.fromJson(json);
}

/// @nodoc
class _$BeanTearOff {
  const _$BeanTearOff();

// ignore: unused_element
  _Bean call(
      {@nullable int uid,
      String beanName = '',
      int remainingAmount = 0,
      int firstAmount = 0,
      int oneCupPerGram = 0,
      Roast roast = Roast.mediumRoast,
      @nullable DateTime freshnessDate,
      @nullable DateTime openTime,
      int price = 0,
      List<int> rate = const [0, 0, 0, 0, 0],
      @nullable int cafeId,
      String memo = '',
      String imageUri = '',
      bool isFavorite = false}) {
    return _Bean(
      uid: uid,
      beanName: beanName,
      remainingAmount: remainingAmount,
      firstAmount: firstAmount,
      oneCupPerGram: oneCupPerGram,
      roast: roast,
      freshnessDate: freshnessDate,
      openTime: openTime,
      price: price,
      rate: rate,
      cafeId: cafeId,
      memo: memo,
      imageUri: imageUri,
      isFavorite: isFavorite,
    );
  }

// ignore: unused_element
  Bean fromJson(Map<String, Object> json) {
    return Bean.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Bean = _$BeanTearOff();

/// @nodoc
mixin _$Bean {
  @nullable
  int get uid;
  String get beanName;
  int get remainingAmount; // 残量
  int get firstAmount; // 最初の量
  int get oneCupPerGram; // 一杯当たりの豆の量
  Roast get roast; // 焙煎
  @nullable
  DateTime get freshnessDate; // 賞味期限
  @nullable
  DateTime get openTime; // 開封日時
  int get price; // 値段
  List<int> get rate; // 評価
  @nullable
  int get cafeId;
  String get memo; // メモ
  String get imageUri;
  bool get isFavorite;

  Map<String, dynamic> toJson();
  $BeanCopyWith<Bean> get copyWith;
}

/// @nodoc
abstract class $BeanCopyWith<$Res> {
  factory $BeanCopyWith(Bean value, $Res Function(Bean) then) =
      _$BeanCopyWithImpl<$Res>;
  $Res call(
      {@nullable int uid,
      String beanName,
      int remainingAmount,
      int firstAmount,
      int oneCupPerGram,
      Roast roast,
      @nullable DateTime freshnessDate,
      @nullable DateTime openTime,
      int price,
      List<int> rate,
      @nullable int cafeId,
      String memo,
      String imageUri,
      bool isFavorite});
}

/// @nodoc
class _$BeanCopyWithImpl<$Res> implements $BeanCopyWith<$Res> {
  _$BeanCopyWithImpl(this._value, this._then);

  final Bean _value;
  // ignore: unused_field
  final $Res Function(Bean) _then;

  @override
  $Res call({
    Object uid = freezed,
    Object beanName = freezed,
    Object remainingAmount = freezed,
    Object firstAmount = freezed,
    Object oneCupPerGram = freezed,
    Object roast = freezed,
    Object freshnessDate = freezed,
    Object openTime = freezed,
    Object price = freezed,
    Object rate = freezed,
    Object cafeId = freezed,
    Object memo = freezed,
    Object imageUri = freezed,
    Object isFavorite = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed ? _value.uid : uid as int,
      beanName: beanName == freezed ? _value.beanName : beanName as String,
      remainingAmount: remainingAmount == freezed
          ? _value.remainingAmount
          : remainingAmount as int,
      firstAmount:
          firstAmount == freezed ? _value.firstAmount : firstAmount as int,
      oneCupPerGram: oneCupPerGram == freezed
          ? _value.oneCupPerGram
          : oneCupPerGram as int,
      roast: roast == freezed ? _value.roast : roast as Roast,
      freshnessDate: freshnessDate == freezed
          ? _value.freshnessDate
          : freshnessDate as DateTime,
      openTime: openTime == freezed ? _value.openTime : openTime as DateTime,
      price: price == freezed ? _value.price : price as int,
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
abstract class _$BeanCopyWith<$Res> implements $BeanCopyWith<$Res> {
  factory _$BeanCopyWith(_Bean value, $Res Function(_Bean) then) =
      __$BeanCopyWithImpl<$Res>;
  @override
  $Res call(
      {@nullable int uid,
      String beanName,
      int remainingAmount,
      int firstAmount,
      int oneCupPerGram,
      Roast roast,
      @nullable DateTime freshnessDate,
      @nullable DateTime openTime,
      int price,
      List<int> rate,
      @nullable int cafeId,
      String memo,
      String imageUri,
      bool isFavorite});
}

/// @nodoc
class __$BeanCopyWithImpl<$Res> extends _$BeanCopyWithImpl<$Res>
    implements _$BeanCopyWith<$Res> {
  __$BeanCopyWithImpl(_Bean _value, $Res Function(_Bean) _then)
      : super(_value, (v) => _then(v as _Bean));

  @override
  _Bean get _value => super._value as _Bean;

  @override
  $Res call({
    Object uid = freezed,
    Object beanName = freezed,
    Object remainingAmount = freezed,
    Object firstAmount = freezed,
    Object oneCupPerGram = freezed,
    Object roast = freezed,
    Object freshnessDate = freezed,
    Object openTime = freezed,
    Object price = freezed,
    Object rate = freezed,
    Object cafeId = freezed,
    Object memo = freezed,
    Object imageUri = freezed,
    Object isFavorite = freezed,
  }) {
    return _then(_Bean(
      uid: uid == freezed ? _value.uid : uid as int,
      beanName: beanName == freezed ? _value.beanName : beanName as String,
      remainingAmount: remainingAmount == freezed
          ? _value.remainingAmount
          : remainingAmount as int,
      firstAmount:
          firstAmount == freezed ? _value.firstAmount : firstAmount as int,
      oneCupPerGram: oneCupPerGram == freezed
          ? _value.oneCupPerGram
          : oneCupPerGram as int,
      roast: roast == freezed ? _value.roast : roast as Roast,
      freshnessDate: freshnessDate == freezed
          ? _value.freshnessDate
          : freshnessDate as DateTime,
      openTime: openTime == freezed ? _value.openTime : openTime as DateTime,
      price: price == freezed ? _value.price : price as int,
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
class _$_Bean implements _Bean {
  const _$_Bean(
      {@nullable this.uid,
      this.beanName = '',
      this.remainingAmount = 0,
      this.firstAmount = 0,
      this.oneCupPerGram = 0,
      this.roast = Roast.mediumRoast,
      @nullable this.freshnessDate,
      @nullable this.openTime,
      this.price = 0,
      this.rate = const [0, 0, 0, 0, 0],
      @nullable this.cafeId,
      this.memo = '',
      this.imageUri = '',
      this.isFavorite = false})
      : assert(beanName != null),
        assert(remainingAmount != null),
        assert(firstAmount != null),
        assert(oneCupPerGram != null),
        assert(roast != null),
        assert(price != null),
        assert(rate != null),
        assert(memo != null),
        assert(imageUri != null),
        assert(isFavorite != null);

  factory _$_Bean.fromJson(Map<String, dynamic> json) =>
      _$_$_BeanFromJson(json);

  @override
  @nullable
  final int uid;
  @JsonKey(defaultValue: '')
  @override
  final String beanName;
  @JsonKey(defaultValue: 0)
  @override
  final int remainingAmount;
  @JsonKey(defaultValue: 0)
  @override // 残量
  final int firstAmount;
  @JsonKey(defaultValue: 0)
  @override // 最初の量
  final int oneCupPerGram;
  @JsonKey(defaultValue: Roast.mediumRoast)
  @override // 一杯当たりの豆の量
  final Roast roast;
  @override // 焙煎
  @nullable
  final DateTime freshnessDate;
  @override // 賞味期限
  @nullable
  final DateTime openTime;
  @JsonKey(defaultValue: 0)
  @override // 開封日時
  final int price;
  @JsonKey(defaultValue: const [0, 0, 0, 0, 0])
  @override // 値段
  final List<int> rate;
  @override // 評価
  @nullable
  final int cafeId;
  @JsonKey(defaultValue: '')
  @override
  final String memo;
  @JsonKey(defaultValue: '')
  @override // メモ
  final String imageUri;
  @JsonKey(defaultValue: false)
  @override
  final bool isFavorite;

  @override
  String toString() {
    return 'Bean(uid: $uid, beanName: $beanName, remainingAmount: $remainingAmount, firstAmount: $firstAmount, oneCupPerGram: $oneCupPerGram, roast: $roast, freshnessDate: $freshnessDate, openTime: $openTime, price: $price, rate: $rate, cafeId: $cafeId, memo: $memo, imageUri: $imageUri, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Bean &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.beanName, beanName) ||
                const DeepCollectionEquality()
                    .equals(other.beanName, beanName)) &&
            (identical(other.remainingAmount, remainingAmount) ||
                const DeepCollectionEquality()
                    .equals(other.remainingAmount, remainingAmount)) &&
            (identical(other.firstAmount, firstAmount) ||
                const DeepCollectionEquality()
                    .equals(other.firstAmount, firstAmount)) &&
            (identical(other.oneCupPerGram, oneCupPerGram) ||
                const DeepCollectionEquality()
                    .equals(other.oneCupPerGram, oneCupPerGram)) &&
            (identical(other.roast, roast) ||
                const DeepCollectionEquality().equals(other.roast, roast)) &&
            (identical(other.freshnessDate, freshnessDate) ||
                const DeepCollectionEquality()
                    .equals(other.freshnessDate, freshnessDate)) &&
            (identical(other.openTime, openTime) ||
                const DeepCollectionEquality()
                    .equals(other.openTime, openTime)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
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
      const DeepCollectionEquality().hash(beanName) ^
      const DeepCollectionEquality().hash(remainingAmount) ^
      const DeepCollectionEquality().hash(firstAmount) ^
      const DeepCollectionEquality().hash(oneCupPerGram) ^
      const DeepCollectionEquality().hash(roast) ^
      const DeepCollectionEquality().hash(freshnessDate) ^
      const DeepCollectionEquality().hash(openTime) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(rate) ^
      const DeepCollectionEquality().hash(cafeId) ^
      const DeepCollectionEquality().hash(memo) ^
      const DeepCollectionEquality().hash(imageUri) ^
      const DeepCollectionEquality().hash(isFavorite);

  @override
  _$BeanCopyWith<_Bean> get copyWith =>
      __$BeanCopyWithImpl<_Bean>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BeanToJson(this);
  }
}

abstract class _Bean implements Bean {
  const factory _Bean(
      {@nullable int uid,
      String beanName,
      int remainingAmount,
      int firstAmount,
      int oneCupPerGram,
      Roast roast,
      @nullable DateTime freshnessDate,
      @nullable DateTime openTime,
      int price,
      List<int> rate,
      @nullable int cafeId,
      String memo,
      String imageUri,
      bool isFavorite}) = _$_Bean;

  factory _Bean.fromJson(Map<String, dynamic> json) = _$_Bean.fromJson;

  @override
  @nullable
  int get uid;
  @override
  String get beanName;
  @override
  int get remainingAmount;
  @override // 残量
  int get firstAmount;
  @override // 最初の量
  int get oneCupPerGram;
  @override // 一杯当たりの豆の量
  Roast get roast;
  @override // 焙煎
  @nullable
  DateTime get freshnessDate;
  @override // 賞味期限
  @nullable
  DateTime get openTime;
  @override // 開封日時
  int get price;
  @override // 値段
  List<int> get rate;
  @override // 評価
  @nullable
  int get cafeId;
  @override
  String get memo;
  @override // メモ
  String get imageUri;
  @override
  bool get isFavorite;
  @override
  _$BeanCopyWith<_Bean> get copyWith;
}
