import 'package:coffee_life_manager/database/model/repository/entity_repository.dart';
import 'package:coffee_life_manager/database/shared_pref.dart';
import 'package:coffee_life_manager/entity/cafe_coffee.dart';
import 'package:flutter_riverpod/all.dart';

final cafeCoffeeList = StateProvider<List<CafeCoffee>>(
  (ref) {
    final list = ref.watch(_cafeCoffeeList).state;
    final order = ref.watch(cafeCoffeeSortOrder).state;
    if (list == null) return null;

    switch (order) {
      case CafeCoffeeListSortOrder.ascByUid:
        list.sort((a, b) => (a?.uid ?? 0) - (b?.uid ?? 0));
        break;
      case CafeCoffeeListSortOrder.desByUid:
        list.sort((a, b) => (b?.uid ?? 0) - (a?.uid ?? 0));
        break;
      case CafeCoffeeListSortOrder.ascByPrice:
        list.sort(
          (a, b) => (a?.price ?? 0) != (b?.price ?? 0)
              ? (a?.price ?? 0) - (b?.price ?? 0)
              : (a?.uid ?? 0) - (b?.uid ?? 0),
        );
        break;
      case CafeCoffeeListSortOrder.desByPrice:
        list.sort(
          (a, b) => (a?.price ?? 0) != (b?.price ?? 0)
              ? (b?.price ?? 0) - (a?.price ?? 0)
              : (a?.uid ?? 0) - (b?.uid ?? 0),
        );
        break;
    }
    return list;
  },
);

final cafeCoffeeListController =
    Provider.autoDispose((ref) => CafeCoffeeListController(ref.read));
final _cafeCoffeeList = StateProvider<List<CafeCoffee>>((ref) => null);
final cafeCoffeeSortOrder =
    StateProvider((ref) => CafeCoffeeListSortOrder.ascByUid);
final cafeCoffeeFavorite = StateProvider((_) => false);

class CafeCoffeeListController {
  CafeCoffeeListController(this.read);
  final Reader read;

  Future<void> changeFavorite() async {
    final fav =
        read(cafeCoffeeFavorite).state = !read(cafeCoffeeFavorite).state;
    if (fav) {
      read(_cafeCoffeeList).state =
          await read(cafeCoffeeRepository).fetchFavorite();
    } else {
      read(_cafeCoffeeList).state = await read(cafeCoffeeRepository).fetchAll();
    }
  }

  Future<void> fetchAll() async {
    read(_cafeCoffeeList).state = await read(cafeCoffeeRepository).fetchAll();
  }

  Future<void> fetchByCafeId(int cafeId) async {
    read(_cafeCoffeeList).state =
        await read(cafeCoffeeRepository).fetchByCafeId(cafeId);
  }

  Future<void> initState() async {
    final index = await read(cafeCoffeeListOrderPref).fetchIndex();
    if (index != null) {
      read(cafeCoffeeSortOrder).state = CafeCoffeeListSortOrder.values[index];
    }
  }

  Future<void> dispose() async {
    read(_cafeCoffeeList).state = null;
    final order = read(cafeCoffeeSortOrder).state;
    await read(cafeCoffeeListOrderPref).save(order.index);
  }

  Future<void> add(CafeCoffee cafeCoffee) async {
    final id = await read(cafeCoffeeRepository).insert(cafeCoffee);

    final list = read(_cafeCoffeeList).state..add(cafeCoffee.copyWith(uid: id));
    read(_cafeCoffeeList).state = list;
  }

  void update(CafeCoffee cafeCoffee) {
    read(cafeCoffeeRepository).update(cafeCoffee);

    final list = read(_cafeCoffeeList).state;
    final index = list.indexWhere((element) => element.uid == cafeCoffee.uid);
    if (index == -1) return;
    list[index] = cafeCoffee;
    read(_cafeCoffeeList).state = list;
  }

  void removeFromRepository(CafeCoffee cafeCoffee) {
    final list = read(_cafeCoffeeList).state;
    list.remove(cafeCoffee);
    read(_cafeCoffeeList).state = list;
    read(cafeCoffeeRepository).delete(cafeCoffee);
  }

  // ignore: use_setters_to_change_properties
  void changeSortOrder(CafeCoffeeListSortOrder order) {
    read(cafeCoffeeSortOrder).state = order;
  }
}

enum CafeCoffeeListSortOrder {
  ascByUid,
  desByUid,
  ascByPrice,
  desByPrice, // TODO: add others
}

const kCafeCoffeeListSortOrderStr = <CafeCoffeeListSortOrder, String>{
  CafeCoffeeListSortOrder.ascByUid: '追加したのが早い順',
  CafeCoffeeListSortOrder.desByUid: '追加したのが遅い順',
  CafeCoffeeListSortOrder.ascByPrice: '値段が安い順',
  CafeCoffeeListSortOrder.desByPrice: '値段が高い順',
};
