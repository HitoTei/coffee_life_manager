import 'package:coffee_life_manager/entity/cafe.dart';

abstract class CafeDao {
  Future<List<Cafe>> fetchAll();

  Future<List<Cafe>> fetchFavorite();

  Future<Cafe> fetchByUid(int uid);

  Future<int> insert(Cafe cafe);

  Future<int> delete(Cafe cafe);

  Future<int> update(Cafe cafe);
}
