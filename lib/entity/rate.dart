import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Rate {
  Rate()
      : values = <String, int>{
          bitternessKey: 0,
          sournessKey: 0,
          fragranceKey: 0,
          richKey: 0,
          sweetnessKey: 0,
        };

  Rate.fromJsonStr(String json)
      : values = (jsonDecode(json) as Map<String, dynamic>).cast<String, int>();

  Rate copyWith({
    @required String rateKey,
    @required int value,
  }) {
    return this..values[rateKey] = value;
  }

  final Map<String, int> values;

  String toJsonStr() {
    return jsonEncode(values);
  }
}

const bitternessDisplayString = '苦味';
const sournessDisplayString = '酸味';
const fragranceDisplayString = '香り';
const richDisplayString = 'コク';
const sweetnessDisplayString = '甘味';

const bitternessKey = 'bitternessKey';
const sournessKey = 'sournessKey';
const fragranceKey = 'fragranceKey';
const richKey = 'richKey';
const sweetnessKey = 'sweetnessKey';
