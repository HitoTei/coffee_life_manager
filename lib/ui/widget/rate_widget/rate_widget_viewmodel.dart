import 'dart:developer' as dev;
import 'dart:math';

import 'package:coffee_life_manager/model/rate.dart';

class RateWidgetViewModel {
  RateWidgetViewModel(this.rate);

  final Rate rate;

  void setValue(String key, int value) {
    if (value < 0 || value >= 5) {
      dev.log('"Illegal value" rate.values[$key] is $value');
      rate.values[key] = min(4, max(0, value));
      return;
    }
    rate.values[key] = value;
  }
}
