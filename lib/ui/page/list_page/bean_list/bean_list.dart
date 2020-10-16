import 'package:coffee_life_manager/database/model/repository/entity_repository.dart';
import 'package:coffee_life_manager/database/shared_pref.dart';
import 'package:coffee_life_manager/entity/bean.dart';
import 'package:flutter_riverpod/all.dart';

final beanList = StateProvider<List<Bean>>(
  (ref) {
    final list = ref.watch(_beanList).state;
    final order = ref.watch(beanSortOrder).state;
    if (list == null) return null;

    switch (order) {
      case BeanListSortOrder.ascByUid:
        list.sort((a, b) => (a?.uid ?? 0) - (b?.uid ?? 0));
        break;
      case BeanListSortOrder.desByUid:
        list.sort((a, b) => (b?.uid ?? 0) - (a?.uid ?? 0));
        break;
      case BeanListSortOrder.ascByPrice: // 値段が同じだった場合, uidでソートする
        list.sort((a, b) => (a.price == b.price)
            ? (b?.uid ?? 0) - (a?.uid ?? 0)
            : (a?.price ?? 0) - (b?.price ?? 0));
        break;
      case BeanListSortOrder.desByPrice:
        list.sort((a, b) => (a.price == b.price)
            ? (b?.uid ?? 0) - (a?.uid ?? 0)
            : (b?.price ?? 0) - (a?.price ?? 0));
        break;
    }
    return list;
  },
);

final beanListController =
    Provider.autoDispose((ref) => BeanListController(ref.read));
final _beanList = StateProvider<List<Bean>>((ref) => null);
final beanSortOrder = StateProvider((ref) => BeanListSortOrder.ascByUid);
final beanFavorite = StateProvider((ref) => false);

class BeanListController {
  BeanListController(this.read);
  final Reader read;

  Future<void> fetchAll() async {
    read(_beanList).state = await read(beanRepository).fetchAll();
  }

  Future<void> changeFavorite() async {
    final fav = read(beanFavorite).state = !read(beanFavorite).state;
    if (fav) {
      read(_beanList).state = await read(beanRepository).fetchFavorite();
    } else {
      read(_beanList).state = await read(beanRepository).fetchAll();
    }
  }

  Future<void> fetchByCafeId(int cafeId) async {
    read(_beanList).state = await read(beanRepository).fetchByCafeId(cafeId);
  }

  Future<void> initState() async {
    final index = await read(beanListOrderPref).fetchIndex();
    if (index != null) {
      read(beanSortOrder).state = BeanListSortOrder.values[index];
    }
  }

  Future<void> dispose() async {
    read(_beanList).state = null;
    await read(beanListOrderPref).save(read(beanSortOrder).state.index);
  }

  Future<void> add(Bean bean) async {
    final id = await read(beanRepository).insert(bean);

    final list = read(_beanList).state
      ..add(
        bean.copyWith(uid: id),
      );
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

  void removeFromRepository(Bean bean) {
    final list = read(_beanList).state;
    list.remove(bean);
    read(_beanList).state = list;
    read(beanRepository).delete(bean);
  }

  // ignore: use_setters_to_change_properties
  void changeSortOrder(BeanListSortOrder order) {
    read(beanSortOrder).state = order;
  }
}

enum BeanListSortOrder {
  ascByUid,
  desByUid,
  ascByPrice,
  desByPrice, // TODO: add others
}

const kBeanListSortOrderStr = <BeanListSortOrder, String>{
  BeanListSortOrder.ascByUid: '追加したのが早い順',
  BeanListSortOrder.desByUid: '追加したのが遅い順',
  BeanListSortOrder.ascByPrice: '値段が安い順',
  BeanListSortOrder.desByPrice: '値段が高い順',
};