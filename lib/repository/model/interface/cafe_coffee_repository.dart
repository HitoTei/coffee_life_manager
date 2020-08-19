import 'package:coffee_life_manager/model/cafe_coffee.dart';

abstract class CafeCoffeeRepository {
  Future<List<CafeCoffee>> fetchAll();

  Future<List<CafeCoffee>> fetchFavorite();

  Future<List<CafeCoffee>> fetchByCafeId(int cafeId);

  Future<CafeCoffee> fetchByUid(int uid);

  Future<int> save(CafeCoffee cafe);

  Future<int> delete(CafeCoffee cafe);

  Future<int> update(CafeCoffee cafe);
}
