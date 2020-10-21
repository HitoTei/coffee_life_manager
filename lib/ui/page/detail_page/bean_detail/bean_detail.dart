import 'dart:io';

import 'package:coffee_life_manager/database/model/repository/entity_repository.dart';
import 'package:coffee_life_manager/entity/bean.dart';
import 'package:coffee_life_manager/ui/page/list_page/house_coffee_list/house_coffee_list.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

final beanDetail = StateProvider.autoDispose<Bean>((_) => null);
final beanDetailController =
    Provider.autoDispose((ref) => BeanDetailController(ref.read));

class BeanDetailController {
  const BeanDetailController(this.read);
  final Reader read;
  Future<void> init(int id) async {
    final uid = id ?? read(beanDetail).state?.uid;
    if (uid != null) {
      read(beanDetail).state = await read(beanRepository).fetchByUid(uid);
    } else {
      final id = await read(beanRepository).insert(const Bean());
      read(beanDetail).state = await read(beanRepository).fetchByUid(id);
    }
    await read(houseCoffeeListController).fetchByBeanId(
      read(beanDetail).state.uid,
    );
  }

  Future<void> update(Bean bean) async {
    read(beanDetail).state = bean;
    await read(beanRepository).update(bean);
  }

  Future<void> setImage(PickedFile file) async {
    final path = (await getApplicationDocumentsDirectory()).path;
    final imageUri = '${DateTime.now()}.png';
    await File(file.path).copy('$path/$imageUri');

    final bean = read(beanDetail).state;
    await update(bean.copyWith(imageUri: imageUri));
  }
}
