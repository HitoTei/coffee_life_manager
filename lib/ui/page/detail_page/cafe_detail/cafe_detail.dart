import 'dart:io';

import 'package:coffee_life_manager/database/model/repository/entity_repository.dart';
import 'package:coffee_life_manager/entity/cafe.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_coffee_list/cafe_coffee_list.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

final cafeDetail = StateProvider.autoDispose<Cafe>((_) => null);
final cafeDetailController =
    Provider.autoDispose((ref) => CafeDetailController(ref.read));

class CafeDetailController {
  const CafeDetailController(this.read);
  final Reader read;
  Future<void> init(int id) async {
    final uid = id ?? read(cafeDetail).state?.uid;
    if (uid != null) {
      read(cafeDetail).state = await read(cafeRepository).fetchByUid(uid);
    } else {
      final id = await read(cafeRepository).insert(const Cafe());
      read(cafeDetail).state = Cafe(uid: id);
    }
    await read(cafeCoffeeListController).fetchByCafeId(
      read(cafeDetail).state.uid,
    );
  }

  Future<void> update(Cafe cafe) async {
    read(cafeDetail).state = cafe;
    await read(cafeRepository).update(cafe);
  }

  Future<void> setImage(PickedFile file) async {
    final path = (await getApplicationDocumentsDirectory()).path;
    final imageUri = DateTime.now().toString();
    await File(file.path).copy('$path/$imageUri');

    final cafe = read(cafeDetail).state;
    await update(cafe.copyWith(imageUri: imageUri));
  }
}
