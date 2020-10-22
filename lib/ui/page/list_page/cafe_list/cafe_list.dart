import 'package:coffee_life_manager/database/model/repository/entity_repository.dart';
import 'package:coffee_life_manager/database/shared_pref.dart';
import 'package:coffee_life_manager/entity/cafe.dart';
import 'package:flutter_riverpod/all.dart';

final cafeList = StateProvider<List<Cafe>>(
  (ref) {
    final list = ref.watch(_cafeList).state;
    final order = ref.watch(cafeSortOrder).state;
    if (list == null) return null;
    switch (order) {
      case CafeListSortOrder.ascByUid:
        list.sort((a, b) => (a?.uid ?? 0) - (b?.uid ?? 0));
        break;
      case CafeListSortOrder.desByUid:
        list.sort((a, b) => (b?.uid ?? 0) - (a?.uid ?? 0));
        break;
    }
    return list;
  },
);

final cafeListController =
    Provider.autoDispose((ref) => CafeListController(ref.read));

final _cafeList = StateProvider<List<Cafe>>((ref) => null);
final cafeSortOrder = StateProvider((ref) => CafeListSortOrder.ascByUid);
final cafeFavorite = StateProvider.autoDispose((_) => false);

class CafeListController {
  CafeListController(this.read);
  final Reader read;

  Future<void> changeFavorite() async {
    final fav = read(cafeFavorite).state = !read(cafeFavorite).state;
    if (fav) {
      read(_cafeList).state = await read(cafeRepository).fetchFavorite();
    } else {
      read(_cafeList).state = await read(cafeRepository).fetchAll();
    }
  }

  Future<void> fetchAll() async {
    read(_cafeList).state = await read(cafeRepository).fetchAll();
  }

  Future<void> initState() async {
    final index = await read(cafeListOrderPref).fetchIndex();
    if (index != null) {
      read(cafeSortOrder).state = CafeListSortOrder.values[index];
    }
  }

  Future<void> dispose() async {
    read(_cafeList).state = null;
    await read(cafeListOrderPref).save(read(cafeSortOrder).state.index);
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

  void removeFromRepository(Cafe cafe) {
    final list = read(_cafeList).state;
    list.remove(cafe);
    read(_cafeList).state = list;
    read(cafeRepository).delete(cafe);
  }

  // ignore: use_setters_to_change_properties
  void changeSortOrder(CafeListSortOrder order) {
    read(cafeSortOrder).state = order;
  }
}

enum CafeListSortOrder {
  desByUid, // add others
  ascByUid,
}

const kCafeListSortOrderStr = <CafeListSortOrder, String>{
  CafeListSortOrder.ascByUid: '追加したのが古い順',
  CafeListSortOrder.desByUid: '追加したのが新しい',
};
