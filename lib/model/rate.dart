import 'dart:convert';

import '../constant_string.dart';

class Rate {
  Rate();

  Rate.fromJsonStr(String json) {
    final map = jsonDecode(json) as Map<String, dynamic>;
    bitterness = map[bitternessKey] as int;
    sourness = map[sournessKey] as int;
    fragrance = map[fragranceKey] as int;
    rich = map[richKey] as int;
    overall = map[overallKey] as int;
  }

  int bitterness = 0;
  int sourness = 0;
  int fragrance = 0;
  int rich = 0;
  int overall = 0;

  String toJsonStr() {
    final map = <String, dynamic>{
      bitternessKey: bitterness,
      sournessKey: sourness,
      fragranceKey: fragrance,
      richKey: rich,
      overallKey: overall,
    };
    return jsonEncode(map);
  }
}
