import 'dart:math';

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
import 'package:coffee_life_manager/function/files.dart';
import 'package:riverpod/all.dart';
import 'package:sqflite/sqflite.dart';

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

class BeanRepository implements EntityRepository<Bean> {
  BeanRepository(this.read);

  final Reader read;
  static const _table = SqlDatabase.beanTable;

  @override
  Future<List<Bean>> fetchAll() async {
    final list = await read(_entityRepository).fetchAll(_table);
    return list.map((e) => Bean.fromJson(e)).toList();
  }

  @override
  Future<List<Bean>> fetchFavorite() async {
    final list = await read(_entityRepository).fetchFavorite(_table);
    return list.map((e) => Bean.fromJson(e)).toList();
  }

  Future<List<Bean>> fetchByCafeId(int cafeId) async {
    final list = await read(_entityRepository).fetchByCafeId(_table, cafeId);
    return list.map((e) => Bean.fromJson(e)).toList();
  }

  @override
  Future<Bean> fetchByUid(int uid) async {
    final map = await read(_entityRepository).fetchByUid(_table, uid);
    return Bean.fromJson(map);
  }

  @override
  Future<int> insert(Bean bean) async {
    return read(_entityRepository).insert(_table, bean.toJson());
  }

  @override
  Future<int> delete(Bean bean) async {
    return read(_entityRepository).delete(_table, bean.toJson());
  }

  @override
  Future<int> update(Bean bean) async {
    return read(_entityRepository).update(_table, bean.toJson());
  }
}

class CafeRepository implements EntityRepository<Cafe> {
  CafeRepository(this.read);

  final Reader read;
  static const _table = SqlDatabase.cafeTable;
  @override
  Future<List<Cafe>> fetchAll() async {
    final list = await read(_entityRepository).fetchAll(_table);
    return list.map((e) => Cafe.fromJson(e)).toList();
  }

  @override
  Future<List<Cafe>> fetchFavorite() async {
    final list = await read(_entityRepository).fetchFavorite(_table);
    return list.map((e) => Cafe.fromJson(e)).toList();
  }

  @override
  Future<Cafe> fetchByUid(int uid) async {
    final map = await read(_entityRepository).fetchByUid(_table, uid);
    return Cafe.fromJson(map);
  }

  @override
  Future<int> insert(Cafe cafe) async {
    return read(_entityRepository).insert(_table, cafe.toJson());
  }

  @override
  Future<int> delete(Cafe cafe) async {
    return read(_entityRepository).delete(_table, cafe.toJson());
  }

  @override
  Future<int> update(Cafe cafe) async {
    return read(_entityRepository).update(_table, cafe.toJson());
  }
}

class CafeCoffeeRepository implements EntityRepository<CafeCoffee> {
  CafeCoffeeRepository(this.read);

  final Reader read;
  static const _table = SqlDatabase.cafeCoffeeTable;
  @override
  Future<List<CafeCoffee>> fetchAll() async {
    final list = await read(_entityRepository).fetchAll(_table);
    return list.map((e) => CafeCoffee.fromJson(e)).toList();
  }

  @override
  Future<List<CafeCoffee>> fetchFavorite() async {
    final list = await read(_entityRepository).fetchFavorite(_table);
    return list.map((e) => CafeCoffee.fromJson(e)).toList();
  }

  Future<List<CafeCoffee>> fetchByCafeId(int cafeId) async {
    final list = await read(_entityRepository).fetchByCafeId(_table, cafeId);
    return list.map((e) => CafeCoffee.fromJson(e)).toList();
  }

  @override
  Future<CafeCoffee> fetchByUid(int uid) async {
    final map = await read(_entityRepository).fetchByUid(_table, uid);
    return CafeCoffee.fromJson(map);
  }

  @override
  Future<int> insert(CafeCoffee cafeCoffee) async {
    return read(_entityRepository).insert(_table, cafeCoffee.toJson());
  }

  @override
  Future<int> delete(CafeCoffee cafeCoffee) async {
    return read(_entityRepository).delete(_table, cafeCoffee.toJson());
  }

  @override
  Future<int> update(CafeCoffee cafeCoffee) async {
    return read(_entityRepository).update(_table, cafeCoffee.toJson());
  }
}

class HouseCoffeeRepository implements EntityRepository<HouseCoffee> {
  HouseCoffeeRepository(this.read);

  final Reader read;
  static const _table = SqlDatabase.houseCoffeeTable;
  @override
  Future<List<HouseCoffee>> fetchAll() async {
    final list = await read(_entityRepository).fetchAll(_table);
    return list.map((e) => HouseCoffee.fromJson(e)).toList();
  }

  @override
  Future<List<HouseCoffee>> fetchFavorite() async {
    final list = await read(_entityRepository).fetchFavorite(_table);
    return list.map((e) => HouseCoffee.fromJson(e)).toList();
  }

  Future<List<HouseCoffee>> fetchByBeanId(int beanId) async {
    final list = await read(_entityRepository).fetchByBeanId(_table, beanId);
    return list.map((e) => HouseCoffee.fromJson(e)).toList();
  }

  @override
  Future<HouseCoffee> fetchByUid(int uid) async {
    final map = await read(_entityRepository).fetchByUid(_table, uid);
    return HouseCoffee.fromJson(map);
  }

  @override
  Future<int> insert(HouseCoffee houseCoffee) async {
    return read(_entityRepository).insert(_table, houseCoffee.toJson());
  }

  @override
  Future<int> delete(HouseCoffee houseCoffee) async {
    return read(_entityRepository).delete(_table, houseCoffee.toJson());
  }

  @override
  Future<int> update(HouseCoffee houseCoffee) async {
    return read(_entityRepository).update(_table, houseCoffee.toJson());
  }
}

abstract class EntityRepository<T> {
  Future<List<T>> fetchAll();

  Future<List<T>> fetchFavorite();

  Future<T> fetchByUid(int uid);

  Future<int> insert(T val);

  Future<int> delete(T val);

  Future<int> update(T val);
}

final _entityRepository =
    Provider.autoDispose((ref) => RawEntityRepository(ref.read));

class RawEntityRepository {
  RawEntityRepository(this.read);

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
      where: '$uidKey = ?',
      whereArgs: <dynamic>[uid],
    );
    return sqlToInstance(mapList[0]);
  }

  Future<int> insert(String table, Map<String, dynamic> json) async {
    final db = await read(sqlDatabase).database;
    final insert = instanceToSql(json);
    return db.insert(
      table,
      insert,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> delete(String table, Map<String, dynamic> json) async {
    final imageUri = json[imageUriKey] as String;
    await deleteFile(imageUri);
    final db = await read(sqlDatabase).database;
    return db.delete(
      table,
      where: '$uidKey = ?',
      whereArgs: <dynamic>[json[uidKey]],
    );
  }

  Future<int> update(String table, Map<String, dynamic> json) async {
    final db = await read(sqlDatabase).database;
    return db.update(
      table,
      instanceToSql(json),
      where: '$uidKey = ?',
      whereArgs: <dynamic>[
        json[uidKey],
      ],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

Map<String, dynamic> sqlToInstance(Map<String, dynamic> e) {
  final map = <String, dynamic>{};
  e.forEach((key, dynamic value) {
    if ([roastKey].contains(key)) {
      map[key] = Roast.values[value as int].toString().substring(6);
    } else if ([grindKey].contains(key)) {
      map[key] = Grind.values[value as int].toString().substring(6);
    } else if ([dripKey].contains(key)) {
      map[key] = Drip.values[value as int].toString().substring(5);
    } else if ([freshnessDateKey, openTimeKey].contains(key)) {
      if (value == null || (value as String) == 'null') {
        map[key] = null;
      } else {
        map[key] = (value as String);
      }
    } else if ([rateKey, startTimeKey, endTimeKey].contains(key)) {
      map[key] = (value as String).split(',').map(int.parse).toList();
    } else if ([regularHolidayKey].contains(key)) {
      final intList = (value as String).split(',');
      final val = <String>[];
      for (var value1 in intList) {
        val.add(
            DayOfTheWeek.values[int.parse(value1)].toString().substring(13));
      }
      map[key] = val;
    } else if ([isFavoriteKey].contains(key)) {
      map[key] = (value as int) == 1;
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
      map[key] = Roast.values
          .map((e) => e.toString().substring(6))
          .toList()
          .indexOf(value as String);
    } else if ([grindKey].contains(key)) {
      map[key] = Grind.values
          .map((e) => e.toString().substring(6))
          .toList()
          .indexOf(value as String);
    } else if ([dripKey].contains(key)) {
      map[key] = Drip.values
          .map((e) => e.toString().substring(5))
          .toList()
          .indexOf(value as String);
    } else if ([freshnessDateKey, openTimeKey].contains(key)) {
      map[key] = (value as String).toString();
    } else if ([rateKey, startTimeKey, endTimeKey].contains(key)) {
      final buffer = StringBuffer();
      for (var i = 0; i < (value as List<int>).length; i++) {
        if (i != 0) buffer.write(',');
        buffer.write((value as List<int>)[i].toString());
      }
      map[key] = buffer.toString();
    } else if ([''].contains(key)) {
      map[key] = dayOfTheWeekListToJsonStr(value as List<DayOfTheWeek>);
    } else if ([isFavoriteKey].contains(key)) {
      map[key] = (value as bool) ? 1 : 0;
    } else if ([regularHolidayKey].contains(key)) {
      final list = (value as List<String>)
          .map((e) => DayOfTheWeek.values
              .indexWhere((element) => element.toString().substring(13) == e))
          .toList();
      var str = '';
      for (final value1 in list) {
        str += ',$value1';
      }
      map[key] = str.substring(min(1, str.length));
    } else {
      map[key] = value;
    }
  });
  return map;
}
