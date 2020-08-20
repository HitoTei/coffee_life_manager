import 'package:coffee_life_manager/model/bean.dart';

abstract class BeanDao {
  Future<List<Bean>> fetchAll();

  Future<List<Bean>> fetchFavorite();

  Future<List<Bean>> fetchByCafeId(int cafeId);

  Future<Bean> fetchByUid(int uid);

  Future<int> insert(Bean bean);

  Future<int> delete(Bean bean);

  Future<int> update(Bean bean);
}
