import 'dart:async';

import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/model/cafe.dart';

class HomeViewModel {
  final beanController = StreamController<Bean>.broadcast();
  final cafeController = StreamController<Cafe>.broadcast();

  void dispose() {
    beanController.close();
    cafeController.close();
  }
}
