import 'package:coffee_life_manager/entity/cafe_coffee.dart';

abstract class CafeCoffeeDao {
  Future<List<CafeCoffee>> fetchAll();

  Future<List<CafeCoffee>> fetchFavorite();

  Future<List<CafeCoffee>> fetchByCafeId(int cafeId);

  Future<CafeCoffee> fetchByUid(int uid);

  Future<int> insert(CafeCoffee cafe);

  Future<int> delete(CafeCoffee cafe);

  Future<int> update(CafeCoffee cafe);
}
