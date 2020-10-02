import 'package:coffee_life_manager/database/model/repository/entity_repository.dart';
import 'package:coffee_life_manager/entity/cafe.dart';
import 'package:flutter_riverpod/all.dart';

final cafeList = StateProvider.autoDispose((ref) {
  final list = ref.watch(_cafeList).state;
  final order = ref.watch(_cafeSortOrder).state;
  switch (order) {
    case CafeListSortOrder.ascByUid:
      list.sort((a, b) => a.uid - b.uid);
      break;
    case CafeListSortOrder.desByUid:
      list.sort((a, b) => b.uid - a.uid);
      break;
  }
  return list;
});

final cafeListController =
    Provider.autoDispose((ref) => CafeListController(ref.read));

final _cafeList = StateProvider.autoDispose<List<Cafe>>((ref) => null);
final _cafeSortOrder =
    StateProvider.autoDispose((ref) => CafeListSortOrder.ascByUid);

class CafeListController {
  CafeListController(this.read);
  final Reader read;

  Future<void> fetchAll() async {
    read(_cafeList).state = await read(cafeRepository).fetchAll();
  }

  void add(Cafe cafe) {
    read(cafeRepository).insert(cafe);

    final list = read(_cafeList).state;
    list.add(cafe);
    read(_cafeList).state = list;
  }

  void update(int index, Cafe cafe) {
    read(cafeRepository).update(cafe);

    final list = read(_cafeList).state;
    list[index] = cafe;
    read(_cafeList).state = list;
  }

  void remove(Cafe cafe) {
    read(cafeRepository).delete(cafe);

    final list = read(_cafeList).state;
    list.remove(cafe);
    read(_cafeList).state = list;
  }

  // ignore: use_setters_to_change_properties
  void changeSortOrder(CafeListSortOrder order) {
    read(_cafeSortOrder).state = order;
  }
}

enum CafeListSortOrder {
  ascByUid,
  desByUid, // add others
}
