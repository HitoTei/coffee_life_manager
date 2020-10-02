import 'package:coffee_life_manager/database/model/repository/entity_repository.dart';
import 'package:coffee_life_manager/entity/house_coffee.dart';
import 'package:flutter_riverpod/all.dart';

final houseCoffeeList = StateProvider.autoDispose((ref) {
  final list = ref.watch(_houseCoffeeList).state;
  final order = ref.watch(_houseCoffeeSortOrder).state;
  switch (order) {
    case HouseCoffeeListSortOrder.ascByUid:
      list.sort((a, b) => a.uid - b.uid);
      break;
    case HouseCoffeeListSortOrder.desByUid:
      list.sort((a, b) => b.uid - a.uid);
      break;
  }
  return list;
});
final houseCoffeeListController =
    Provider.autoDispose((ref) => HouseCoffeeListController(ref.read));

final _houseCoffeeList =
    StateProvider.autoDispose<List<HouseCoffee>>((ref) => null);
final _houseCoffeeSortOrder =
    StateProvider.autoDispose((ref) => HouseCoffeeListSortOrder.ascByUid);

class HouseCoffeeListController {
  HouseCoffeeListController(this.read);
  final Reader read;

  Future<void> fetchAll() async {
    read(_houseCoffeeList).state = await read(houseCoffeeRepository).fetchAll();
  }

  void add(HouseCoffee houseCoffee) {
    read(houseCoffeeRepository).insert(houseCoffee);

    final list = read(_houseCoffeeList).state;
    list.add(houseCoffee);
    read(_houseCoffeeList).state = list;
  }

  void update(int index, HouseCoffee houseCoffee) {
    read(houseCoffeeRepository).update(houseCoffee);

    final list = read(_houseCoffeeList).state;
    list[index] = houseCoffee;
    read(_houseCoffeeList).state = list;
  }

  void remove(HouseCoffee houseCoffee) {
    read(houseCoffeeRepository).delete(houseCoffee);

    final list = read(_houseCoffeeList).state;
    list.remove(houseCoffee);
    read(_houseCoffeeList).state = list;
  }

  // ignore: use_setters_to_change_properties
  void changeSortOrder(HouseCoffeeListSortOrder order) {
    read(_houseCoffeeSortOrder).state = order;
  }
}

enum HouseCoffeeListSortOrder {
  ascByUid,
  desByUid, // TODO: add others
}
