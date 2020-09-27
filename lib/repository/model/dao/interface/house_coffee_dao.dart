import 'package:coffee_life_manager/entity/house_coffee.dart';

abstract class HouseCoffeeDao {
  Future<List<HouseCoffee>> fetchAll();

  Future<List<HouseCoffee>> fetchFavorite();

  Future<List<HouseCoffee>> fetchByBeanId(int id);

  Future<HouseCoffee> fetchByUid(int uid);

  Future<int> insert(HouseCoffee coffee);

  Future<int> delete(HouseCoffee coffee);

  Future<int> update(HouseCoffee coffee);
}
