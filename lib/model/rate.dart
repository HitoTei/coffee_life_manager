import '../constant_string.dart';

class Rate {
  Rate();
  Rate.fromMap(Map<String, dynamic> map) {
    uid = map[uidKey] as int;
    bitterness = map[bitternessKey] as int;
    sourness = map[sournessKey] as int;
    fragrance = map[fragranceKey] as int;
    rich = map[richKey] as int;
    overall = map[overallKey] as int;
  }

  int uid;
  int bitterness;
  int sourness;
  int fragrance;
  int rich;
  int overall;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      uidKey: uid,
      bitternessKey: bitterness,
      sournessKey: sourness,
      fragranceKey: fragrance,
      richKey: rich,
      overallKey: overall,
    };
  }
}
