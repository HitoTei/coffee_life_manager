import 'package:coffee_life_manager/function/int_bool_parse.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('int to bool test', () {
    expect(intToBool(1), true);
    expect(intToBool(0), false);
    expect(intToBool(2434), true);
  });
  test('bool to int test', () {
    expect(boolToInt(true), 1);
    expect(boolToInt(false), 0);
  });
}
