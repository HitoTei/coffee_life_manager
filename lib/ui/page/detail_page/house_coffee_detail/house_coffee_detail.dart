import 'dart:io';

import 'package:coffee_life_manager/database/model/repository/entity_repository.dart';
import 'package:coffee_life_manager/entity/bean.dart';
import 'package:coffee_life_manager/entity/house_coffee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

final houseCoffeeDetail = StateProvider.autoDispose<HouseCoffee>((_) => null);
final parentBean = StateProvider.autoDispose<Bean>((_) => null);
final houseCoffeeDetailController =
    Provider.autoDispose((ref) => HouseCoffeeDetailController(ref.read));

class HouseCoffeeDetailController {
  const HouseCoffeeDetailController(this.read);
  final Reader read;
  Future<void> init(int uid, {@required int beanId}) async {
    if (uid != null) {
      read(houseCoffeeDetail).state =
          await read(houseCoffeeRepository).fetchByUid(uid);
    } else {
      final id = await read(houseCoffeeRepository).insert(
        HouseCoffee(
          beanId: beanId,
          drinkDay: DateTime.now(),
        ),
      );
      read(houseCoffeeDetail).state =
          await read(houseCoffeeRepository).fetchByUid(id);
    }

    read(parentBean).state = await read(beanRepository).fetchByUid(
      beanId ?? read(houseCoffeeDetail).state.beanId,
    );
  }

  Future<void> update(HouseCoffee houseCoffee) async {
    read(houseCoffeeDetail).state = houseCoffee;
    await read(houseCoffeeRepository).update(houseCoffee);
  }

  Future<void> setImage(PickedFile file) async {
    final path = (await getApplicationDocumentsDirectory()).path;
    final imageUri = DateTime.now().toString();
    await File(file.path).copy('$path/$imageUri');

    final houseCoffee = read(houseCoffeeDetail).state;
    await update(houseCoffee.copyWith(imageUri: imageUri));
  }
}
