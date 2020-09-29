import 'dart:developer';

import 'package:coffee_life_manager/constant_string.dart';
import 'package:coffee_life_manager/database/sql_database.dart';
import 'package:coffee_life_manager/entity/bean.dart';
import 'package:coffee_life_manager/entity/cafe.dart';
import 'package:coffee_life_manager/entity/cafe_coffee.dart';
import 'package:coffee_life_manager/entity/enums/day_of_the_week.dart';
import 'package:coffee_life_manager/entity/enums/drip.dart';
import 'package:coffee_life_manager/entity/enums/grind.dart';
import 'package:coffee_life_manager/entity/enums/roast.dart';
import 'package:coffee_life_manager/entity/house_coffee.dart';
import 'package:coffee_life_manager/function/get_file.dart';
import 'package:riverpod/all.dart';

final beanRepository = Provider.autoDispose(
  (ref) => BeanRepository(ref.read),
);
final cafeRepository = Provider.autoDispose(
  (ref) => CafeRepository(ref.read),
);
final cafeCoffeeRepository = Provider.autoDispose(
  (ref) => CafeCoffeeRepository(ref.read),
);
final houseCoffeeRepository = Provider.autoDispose(
  (ref) => HouseCoffeeRepository(ref.read),
);

class BeanRepository {
  BeanRepository(this.read);

  final Reader read;
  static const _table = SqlDatabase.beanTable;

  Future<List<Bean>> fetchAll() async {
    final list = await read(_entityRepository).fetchAll(_table);
    return list.map((e) => Bean.fromJson(e)).toList();
  }

  Future<List<Bean>> fetchFavorite() async {
    final list = await read(_entityRepository).fetchFavorite(_table);
    return list.map((e) => Bean.fromJson(e)).toList();
  }

  Future<List<Bean>> fetchByCafeId(int cafeId) async {
    final list = await read(_entityRepository).fetchByCafeId(_table, cafeId);
    return list.map((e) => Bean.fromJson(e)).toList();
  }

  Future<Bean> fetchByUid(int uid) async {
    final map = await read(_entityRepository).fetchByUid(_table, uid);
    return Bean.fromJson(map);
  }

  Future<int> insert(Bean bean) async {
    return read(_entityRepository).insert(_table, bean.toJson());
  }

  Future<int> delete(Bean bean) async {
    return read(_entityRepository).delete(_table, bean.toJson());
  }

  Future<int> update(Bean bean) async {
    return read(_entityRepository).update(_table, bean.toJson());
  }
}

class CafeRepository {
  CafeRepository(this.read);

  final Reader read;
  static const _table = SqlDatabase.cafeTable;

  Future<List<Cafe>> fetchAll() async {
    final list = await read(_entityRepository).fetchAll(_table);
    return list.map((e) => Cafe.fromJson(e)).toList();
  }

  Future<List<Cafe>> fetchFavorite() async {
    final list = await read(_entityRepository).fetchFavorite(_table);
    return list.map((e) => Cafe.fromJson(e)).toList();
  }

  Future<Cafe> fetchByUid(int uid) async {
    final map = await read(_entityRepository).fetchByUid(_table, uid);
    return Cafe.fromJson(map);
  }

  Future<int> insert(Cafe cafe) async {
    return read(_entityRepository).insert(_table, cafe.toJson());
  }

  Future<int> delete(Cafe cafe) async {
    return read(_entityRepository).delete(_table, cafe.toJson());
  }

  Future<int> update(Cafe cafe) async {
    return read(_entityRepository).update(_table, cafe.toJson());
  }
}

class CafeCoffeeRepository {
  CafeCoffeeRepository(this.read);

  final Reader read;
  static const _table = SqlDatabase.cafeCoffeeTable;

  Future<List<CafeCoffee>> fetchAll() async {
    final list = await read(_entityRepository).fetchAll(_table);
    return list.map((e) => CafeCoffee.fromJson(e)).toList();
  }

  Future<List<CafeCoffee>> fetchFavorite() async {
    final list = await read(_entityRepository).fetchFavorite(_table);
    return list.map((e) => CafeCoffee.fromJson(e)).toList();
  }

  Future<List<CafeCoffee>> fetchByCafeId(int cafeId) async {
    final list = await read(_entityRepository).fetchByCafeId(_table, cafeId);
    return list.map((e) => CafeCoffee.fromJson(e)).toList();
  }

  Future<CafeCoffee> fetchByUid(int uid) async {
    final map = await read(_entityRepository).fetchByUid(_table, uid);
    return CafeCoffee.fromJson(map);
  }

  Future<int> insert(CafeCoffee cafeCoffee) async {
    return read(_entityRepository).insert(_table, cafeCoffee.toJson());
  }

  Future<int> delete(CafeCoffee cafeCoffee) async {
    return read(_entityRepository).delete(_table, cafeCoffee.toJson());
  }

  Future<int> update(CafeCoffee cafeCoffee) async {
    return read(_entityRepository).update(_table, cafeCoffee.toJson());
  }
}

class HouseCoffeeRepository {
  HouseCoffeeRepository(this.read);

  final Reader read;
  static const _table = SqlDatabase.houseCoffeeTable;

  Future<List<HouseCoffee>> fetchAll() async {
    final list = await read(_entityRepository).fetchAll(_table);
    return list.map((e) => HouseCoffee.fromJson(e)).toList();
  }

  Future<List<HouseCoffee>> fetchFavorite() async {
    final list = await read(_entityRepository).fetchFavorite(_table);
    return list.map((e) => HouseCoffee.fromJson(e)).toList();
  }

  Future<List<HouseCoffee>> fetchByBeanId(int beanId) async {
    final list = await read(_entityRepository).fetchByBeanId(_table, beanId);
    return list.map((e) => HouseCoffee.fromJson(e)).toList();
  }

  Future<HouseCoffee> fetchByUid(int uid) async {
    final map = await read(_entityRepository).fetchByUid(_table, uid);
    return HouseCoffee.fromJson(map);
  }

  Future<int> insert(HouseCoffee houseCoffee) async {
    return read(_entityRepository).insert(_table, houseCoffee.toJson());
  }

  Future<int> delete(HouseCoffee houseCoffee) async {
    return read(_entityRepository).delete(_table, houseCoffee.toJson());
  }

  Future<int> update(HouseCoffee houseCoffee) async {
    return read(_entityRepository).update(_table, houseCoffee.toJson());
  }
}

final _entityRepository =
    Provider.autoDispose((ref) => EntityRepository(ref.read));

class EntityRepository {
  EntityRepository(this.read);

  final Reader read;

  Future<List<Map<String, dynamic>>> fetchAll(String table) async {
    final db = await read(sqlDatabase).database;
    final mapList = await db.query(table);
    return mapList.map(sqlToInstance).toList();
  }

  Future<List<Map<String, dynamic>>> fetchFavorite(String table) async {
    final db = await read(sqlDatabase).database;
    final mapList = await db.query(
      table,
      where: '$isFavoriteKey = 1',
    );
    return mapList.map(sqlToInstance).toList();
  }

  Future<List<Map<String, dynamic>>> fetchByCafeId(
      String table, int cafeId) async {
    final db = await read(sqlDatabase).database;
    final mapList = await db.query(
      table,
      where: '$cafeIdKey = ?',
      whereArgs: <dynamic>[cafeId],
    );
    return mapList.map(sqlToInstance).toList();
  }

  Future<List<Map<String, dynamic>>> fetchByBeanId(
      String table, int beanId) async {
    final db = await read(sqlDatabase).database;
    final mapList = await db.query(
      table,
      where: '$beanIdKey = ?',
      whereArgs: <dynamic>[beanId],
    );
    return mapList.map(sqlToInstance).toList();
  }

  Future<Map<String, dynamic>> fetchByUid(String table, int uid) async {
    final db = await read(sqlDatabase).database;
    final mapList = await db.query(
      table,
      where: '$uidKey',
      whereArgs: <dynamic>[uid],
    );
    return sqlToInstance(mapList[0]);
  }

  Future<int> insert(String table, Map<String, dynamic> json) async {
    final db = await read(sqlDatabase).database;
    return db.insert(table, instanceToSql(json));
  }

  Future<int> delete(String table, Map<String, dynamic> json) async {
    final imageUri = json[imageUriKey] as String;
    if (imageUri != null) {
      try {
        (await getLocalFile(imageUri)).deleteSync();
      } catch (e) {
        log('Catch exception when deleting image: $e');
      }
    }
    final db = await read(sqlDatabase).database;
    return db.delete(
      table,
      where: '$uidKey = ?',
      whereArgs: <dynamic>[json[uidKey]],
    );
  }

  Future<int> update(String table, Map<String, dynamic> json) async {
    final db = await read(sqlDatabase).database;
    return db.update(table, instanceToSql(json));
  }
}

Map<String, dynamic> sqlToInstance(Map<String, dynamic> e) {
  final map = <String, dynamic>{};
  e.forEach((key, dynamic value) {
    if ([roastKey].contains(key)) {
      map[key] = Roast.values[value as int];
    } else if ([grindKey].contains(key)) {
      map[key] = Grind.values[value as int];
    } else if ([dripKey].contains(key)) {
      map[key] = Drip.values[value as int];
    } else if ([freshnessDateKey, openTimeKey].contains(key)) {
      map[key] = DateTime.parse(value as String);
    } else if ([rateKey, startTimeKey, endTimeKey].contains(key)) {
      map[key] = (value as String).split(',').map(int.parse);
    } else if ([dayOfTheWeekStr].contains(key)) {
      map[key] = jsonStrToDayOfTheWeekList(value as String);
    } else {
      map[key] = value;
    }
  });
  return map;
}

Map<String, dynamic> instanceToSql(Map<String, dynamic> e) {
  final map = <String, dynamic>{};
  e.forEach((key, dynamic value) {
    if ([roastKey].contains(key)) {
      map[key] = Roast.values.indexOf(value as Roast);
    } else if ([grindKey].contains(key)) {
      map[key] = Grind.values.indexOf(value as Grind);
    } else if ([dripKey].contains(key)) {
      map[key] = Drip.values.indexOf(value as Drip);
    } else if ([freshnessDateKey, openTimeKey].contains(key)) {
      map[key] = (value as DateTime).toString();
    } else if ([rateKey, startTimeKey, endTimeKey].contains(key)) {
      final buffer = StringBuffer();
      for (var i = 0; i < (value as List<int>).length; i++) {
        if (i != 0) buffer.write('+');
        buffer.write((value as List<int>)[i].toString());
      }
      map[key] = buffer.toString();
    } else if ([dayOfTheWeekStr].contains(key)) {
      map[key] = dayOfTheWeekListToJsonStr(value as List<DayOfTheWeek>);
    } else {
      map[key] = value;
    }
  });
  return map;
}
