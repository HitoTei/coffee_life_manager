import 'dart:convert';

class Rate {
  Rate()
      : values = {
          bitternessKey: 0,
          sournessKey: 0,
          fragranceKey: 0,
          richKey: 0,
          overallKey: 0,
        };

  Rate.fromJsonStr(String json)
      : values = (jsonDecode(json) as Map<String, dynamic>).cast<String, int>();

  final Map<String, int> values;

  String toJsonStr() {
    return jsonEncode(values);
  }
}

const bitternessDisplayString = '苦味';
const sournessDisplayString = '酸味';
const fragranceDisplayString = '香り';
const richDisplayString = 'コク';
const overallDisplayString = '総合評価';

const bitternessKey = 'bitternessKey';
const sournessKey = 'sournessKey';
const fragranceKey = 'fragranceKey';
const richKey = 'richKey';
const overallKey = 'overallKey';
