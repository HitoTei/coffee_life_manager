import 'dart:io';

import 'package:coffee_life_manager/database/model/repository/entity_repository.dart';
import 'package:coffee_life_manager/entity/cafe.dart';
import 'package:coffee_life_manager/entity/cafe_coffee.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

final parentCafe = StateProvider.autoDispose<Cafe>((_) => null);
final cafeCoffeeDetail = StateProvider.autoDispose<CafeCoffee>((_) => null);
final cafeCoffeeDetailController =
    Provider.autoDispose((ref) => CafeCoffeeDetailController(ref.read));

class CafeCoffeeDetailController {
  const CafeCoffeeDetailController(this.read);
  final Reader read;
  Future<void> init(int uid, int cafeId) async {
    if (uid != null) {
      read(cafeCoffeeDetail).state =
          await read(cafeCoffeeRepository).fetchByUid(uid);
    } else {
      final id = await read(cafeCoffeeRepository).insert(
        CafeCoffee(
          cafeId: cafeId,
          drinkDay: DateTime.now(),
        ),
      );
      read(cafeCoffeeDetail).state =
          await read(cafeCoffeeRepository).fetchByUid(id);
    }

    read(parentCafe).state = await read(cafeRepository).fetchByUid(
      cafeId ?? read(cafeCoffeeDetail).state.cafeId,
    );
  }

  Future<void> update(CafeCoffee cafeCoffee) async {
    read(cafeCoffeeDetail).state = cafeCoffee;
    await read(cafeCoffeeRepository).update(cafeCoffee);
  }

  Future<void> setImage(PickedFile file) async {
    final path = (await getApplicationDocumentsDirectory()).path;
    final imageUri = DateTime.now().toString();
    await File(file.path).copy('$path/$imageUri');

    final cafeCoffee = read(cafeCoffeeDetail).state;
    await update(cafeCoffee.copyWith(imageUri: imageUri));
  }
}
