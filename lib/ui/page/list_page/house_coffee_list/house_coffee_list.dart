import 'package:coffee_life_manager/database/model/repository/entity_repository.dart';
import 'package:coffee_life_manager/database/shared_pref.dart';
import 'package:coffee_life_manager/entity/house_coffee.dart';
import 'package:flutter_riverpod/all.dart';

final houseCoffeeList = StateProvider<List<HouseCoffee>>((ref) {
  final list = ref.watch(_houseCoffeeList).state;
  final order = ref.watch(houseCoffeeSortOrder).state;
  if (list == null) return [];
  switch (order) {
    case HouseCoffeeListSortOrder.ascByUid:
      list.sort((a, b) => (a?.uid ?? 0) - (b?.uid ?? 0));
      break;
    case HouseCoffeeListSortOrder.desByUid:
      list.sort((a, b) => (b?.uid ?? 0) - (a?.uid ?? 0));
      break;
  }
  return list;
});
final houseCoffeeListController =
    Provider.autoDispose((ref) => HouseCoffeeListController(ref.read));

final _houseCoffeeList = StateProvider<List<HouseCoffee>>((ref) => null);
final houseCoffeeSortOrder =
    StateProvider((ref) => HouseCoffeeListSortOrder.ascByUid);

class HouseCoffeeListController {
  HouseCoffeeListController(this.read);
  final Reader read;

  Future<void> fetchAll() async {
    read(_houseCoffeeList).state = await read(houseCoffeeRepository).fetchAll();
  }

  Future<void> fetchByBeanId(int beanId) async {
    read(_houseCoffeeList).state =
        await read(houseCoffeeRepository).fetchByBeanId(beanId);
  }

  Future<void> initState() async {
    final index = await read(houseCoffeeListOrderPref).fetchIndex();
    if (index != null) {
      read(houseCoffeeSortOrder).state = HouseCoffeeListSortOrder.values[index];
    }
  }

  Future<void> dispose() async {
    read(_houseCoffeeList).state = null;
    await read(houseCoffeeListOrderPref)
        .save(read(houseCoffeeSortOrder).state.index);
  }

  void add(HouseCoffee houseCoffee) {
    read(houseCoffeeRepository).insert(houseCoffee);

    final list = read(_houseCoffeeList).state;
    list.add(houseCoffee);
    read(_houseCoffeeList).state = list;
  }

  void update(HouseCoffee houseCoffee) {
    read(houseCoffeeRepository).update(houseCoffee);

    final list = read(_houseCoffeeList).state;
    final index = list.indexWhere((element) => element.uid == houseCoffee.uid);
    list[index] = houseCoffee;
    read(_houseCoffeeList).state = list;
  }

  void removeFromRepository(HouseCoffee houseCoffee) {
    final list = read(_houseCoffeeList).state;
    list.remove(houseCoffee);
    read(_houseCoffeeList).state = list;
    read(houseCoffeeRepository).delete(houseCoffee);
  }

  // ignore: use_setters_to_change_properties
  void changeSortOrder(HouseCoffeeListSortOrder order) {
    read(houseCoffeeSortOrder).state = order;
  }
}

enum HouseCoffeeListSortOrder {
  ascByUid,
  desByUid, // TODO: add others
}

const kHouseCoffeeListSortOrderStr = <HouseCoffeeListSortOrder, String>{
  HouseCoffeeListSortOrder.ascByUid: '追加したのが早い順',
  HouseCoffeeListSortOrder.desByUid: '追加したのが遅い順',
};
