import 'package:flutter_riverpod/all.dart';
import 'package:shared_preferences/shared_preferences.dart';

final beanListOrderPref = Provider.autoDispose(
  (_) => _SharedPref('beanListOrder'),
);
final cafeListOrderPref = Provider.autoDispose(
  (_) => _SharedPref('cafeListOrder'),
);
final houseCoffeeListOrderPref = Provider.autoDispose(
  (_) => _SharedPref('houseCoffeeListOrder'),
);
final cafeCoffeeListOrderPref = Provider.autoDispose(
  (_) => _SharedPref('cafeCoffeeListOrder'),
);

class _SharedPref {
  _SharedPref(this.key);
  final String key;
  Future<int> fetchIndex() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }

  Future<void> save(int value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt(key, value);
  }
}
