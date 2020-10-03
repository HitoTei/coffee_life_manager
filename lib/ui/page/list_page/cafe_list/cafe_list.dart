import 'package:coffee_life_manager/database/model/repository/entity_repository.dart';
import 'package:coffee_life_manager/entity/cafe.dart';
import 'package:flutter_riverpod/all.dart';

final cafeList = StateProvider<List<Cafe>>((ref) {
  final list = ref.watch(_cafeList).state;
  final order = ref.watch(_cafeSortOrder).state;
  switch (order) {
    case CafeListSortOrder.ascByUid:
      list.sort((a, b) => (a?.uid ?? 0) - (b?.uid ?? 0));
      break;
    case CafeListSortOrder.desByUid:
      list.sort((a, b) => (b?.uid ?? 0) - (a?.uid ?? 0));
      break;
  }
  return list;
});

final cafeListController = Provider((ref) => CafeListController(ref.read));

final _cafeList = StateProvider<List<Cafe>>((ref) => null);
final _cafeSortOrder = StateProvider((ref) => CafeListSortOrder.ascByUid);

class CafeListController {
  CafeListController(this.read);
  final Reader read;

  Future<void> fetchAll() async {
    read(_cafeList).state = await read(cafeRepository).fetchAll();
  }

  Future<void> initState() async {
    // orderなどを取得
  }

  Future<void> dispose() async {
    read(_cafeList).state = null;
  }

  void add(Cafe cafe) {
    read(cafeRepository).insert(cafe);

    final list = read(_cafeList).state;
    list.add(cafe);
    read(_cafeList).state = list;
  }

  void update(Cafe cafe) {
    read(cafeRepository).update(cafe);

    final list = read(_cafeList).state;
    final index = list.indexWhere((element) => element.uid == cafe.uid);
    if (index == -1) return;
    list[index] = cafe;
    read(_cafeList).state = list;
  }

  void removeOnlyContentsOfList(Cafe cafe) {
    final list = read(_cafeList).state;
    list.remove(cafe);
    read(_cafeList).state = list;
  }

  void removeContentsOfRepository(Cafe cafe) {
    read(cafeRepository).delete(cafe);
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
