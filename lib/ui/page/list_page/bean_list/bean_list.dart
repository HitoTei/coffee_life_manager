import 'package:coffee_life_manager/database/model/repository/entity_repository.dart';
import 'package:coffee_life_manager/entity/bean.dart';
import 'package:flutter_riverpod/all.dart';

final beanList = StateProvider<List<Bean>>(
  (ref) {
    final list = ref.watch(_beanList).state;
    final order = ref.watch(_beanSortOrder).state;
    if (list == null) return null;

    switch (order) {
      case BeanListSortOrder.ascByUid:
        list.sort((a, b) => (a?.uid ?? 0) - (b?.uid ?? 0));
        break;
      case BeanListSortOrder.desByUid:
        list.sort((a, b) => (b?.uid ?? 0) - (a?.uid ?? 0));
        break;
      case BeanListSortOrder.ascByPrice:
        list.sort((a, b) => (a?.price ?? 0) - (b?.price ?? 0));
        break;
      case BeanListSortOrder.desByPrice:
        list.sort((a, b) => (b?.price ?? 0) - (a?.price ?? 0));
        break;
    }
    return list;
  },
);

final beanListController =
    Provider.autoDispose((ref) => BeanListController(ref.read));
final _beanList = StateProvider<List<Bean>>((ref) => null);
final _beanSortOrder = StateProvider((ref) => BeanListSortOrder.ascByUid);

class BeanListController {
  BeanListController(this.read);
  final Reader read;

  Future<void> fetchAll() async {
    read(_beanList).state = await read(beanRepository).fetchAll();
  }

  Future<void> fetchByCafeId(int cafeId) async {
    read(_beanList).state = await read(beanRepository).fetchByCafeId(cafeId);
  }

  Future<void> initState() async {
    // 並び順とかの取得
  }

  Future<void> dispose() async {
    read(_beanList).state = null;
  }

  Future<void> add(Bean bean) async {
    final id = await read(beanRepository).insert(bean);

    final list = read(_beanList).state..add(bean.copyWith(uid: id));
    read(_beanList).state = list;
  }

  void update(Bean bean) {
    read(beanRepository).update(bean);

    final list = read(_beanList).state;
    final index = list.indexWhere((element) => element.uid == bean.uid);
    if (index == -1) return;
    list[index] = bean;
    read(_beanList).state = list;
  }

  void removeFromList(Bean bean) {
    final list = read(_beanList).state;
    list.remove(bean);
    read(_beanList).state = list;
  }

  void removeFromRepository(Bean bean) {
    read(beanRepository).delete(bean);
  }

  // ignore: use_setters_to_change_properties
  void changeSortOrder(BeanListSortOrder order) {
    read(_beanSortOrder).state = order;
  }
}

enum BeanListSortOrder {
  ascByUid,
  desByUid,
  ascByPrice,
  desByPrice, // TODO: add others
}
