import 'package:coffee_life_manager/database/model/repository/entity_repository.dart';
import 'package:coffee_life_manager/entity/cafe_coffee.dart';
import 'package:flutter_riverpod/all.dart';

final cafeCoffeeList = StateProvider<List<CafeCoffee>>(
  (ref) {
    final list = ref.watch(_cafeCoffeeList).state;
    final order = ref.watch(_cafeCoffeeSortOrder).state;
    if (list == null) return null;

    switch (order) {
      case CafeCoffeeListSortOrder.ascByUid:
        list.sort((a, b) => (a?.uid ?? 0) - (b?.uid ?? 0));
        break;
      case CafeCoffeeListSortOrder.desByUid:
        list.sort((a, b) => (b?.uid ?? 0) - (a?.uid ?? 0));
        break;
      case CafeCoffeeListSortOrder.ascByPrice:
        list.sort((a, b) => (a?.price ?? 0) - (b?.price ?? 0));
        break;
      case CafeCoffeeListSortOrder.desByPrice:
        list.sort((a, b) => (b?.price ?? 0) - (a?.price ?? 0));
        break;
    }
    return list;
  },
);

final cafeCoffeeListController =
    Provider((ref) => CafeCoffeeListController(ref.read));
final _cafeCoffeeList = StateProvider<List<CafeCoffee>>((ref) => null);
final _cafeCoffeeSortOrder =
    StateProvider((ref) => CafeCoffeeListSortOrder.ascByUid);

class CafeCoffeeListController {
  CafeCoffeeListController(this.read);
  final Reader read;

  Future<void> fetchAll() async {
    read(_cafeCoffeeList).state = await read(cafeCoffeeRepository).fetchAll();
  }

  Future<void> fetchByCafeId(int cafeId) async {
    read(_cafeCoffeeList).state =
        await read(cafeCoffeeRepository).fetchByCafeId(cafeId);
  }

  Future<void> initState() async {
    // 並び順とかの取得
  }

  Future<void> dispose() async {
    read(_cafeCoffeeList).state = null;
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

  void remove(CafeCoffee cafeCoffee) {
    read(cafeCoffeeRepository).delete(cafeCoffee);

    final list = read(_cafeCoffeeList).state;
    list.remove(cafeCoffee);
    read(_cafeCoffeeList).state = list;
  }

  // ignore: use_setters_to_change_properties
  void changeSortOrder(CafeCoffeeListSortOrder order) {
    read(_cafeCoffeeSortOrder).state = order;
  }
}

enum CafeCoffeeListSortOrder {
  ascByUid,
  desByUid,
  ascByPrice,
  desByPrice, // TODO: add others
}
