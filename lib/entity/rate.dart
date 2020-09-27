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

  static const bitternessDisplayString = '苦味';
  static const sournessDisplayString = '酸味';
  static const fragranceDisplayString = '香り';
  static const richDisplayString = 'コク';
  static const overallDisplayString = '総合評価';

  static const bitternessKey = 'bitternessKey';
  static const sournessKey = 'sournessKey';
  static const fragranceKey = 'fragranceKey';
  static const richKey = 'richKey';
  static const overallKey = 'overallKey';

  final Map<String, int> values;

  String toJsonStr() {
    return jsonEncode(values);
  }
}
