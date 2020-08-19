import 'package:coffee_life_manager/model/house_coffee.dart';

abstract class HouseCoffeeRepository {
  Future<List<HouseCoffee>> fetchAll();

  Future<List<HouseCoffee>> fetchFavorite();

  Future<List<HouseCoffee>> fetchByBeanId();

  Future<HouseCoffee> fetchByUid(int id);

  Future<int> save(HouseCoffee coffee);

  Future<int> delete(HouseCoffee coffee);

  Future<int> update(HouseCoffee coffee);
}
