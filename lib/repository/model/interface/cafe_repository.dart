import 'package:coffee_life_manager/model/cafe.dart';

abstract class CafeRepository {
  Future<List<Cafe>> fetchAll();

  Future<List<Cafe>> fetchFavorite();

  Future<Cafe> fetchByUid(int uid);

  Future<int> save(Cafe cafe);

  Future<int> delete(Cafe cafe);

  Future<int> update(Cafe cafe);
}
