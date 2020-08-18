import 'package:coffee_life_manager/model/bean.dart';

abstract class BeanRepository {
  Future<List<Bean>> fetchAll();

  Future<List<Bean>> fetchByCafeId(int cafeId);

  Future<Bean> fetchByUid(int uid);

  Future<int> save(Bean bean);

  Future<int> delete(Bean bean);

  Future<int> update(Bean bean);
}
