import 'package:coffee_life_manager/model/rate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Rate Json encoding and decoding test', () {
    final rate = Rate();
    final rateStr = rate.toJsonStr();
    final rateJson = Rate.fromJsonStr(rateStr);
    expect(rate.toJsonStr(), rateJson.toJsonStr());
  });
}
