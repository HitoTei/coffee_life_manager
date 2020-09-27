import 'dart:developer';

import 'package:coffee_life_manager/entity/house_coffee.dart';
import 'package:coffee_life_manager/function/get_file.dart';
import 'package:coffee_life_manager/function/sort_compare.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/house_coffee_dao.dart';
import 'package:sqflite/sqflite.dart';

import '../../../constant_string.dart';
import '../../sql_database.dart';

class HouseCoffeeDaoImpl implements HouseCoffeeDao {
  final _db = SqlDatabase().database;
  final _table = SqlDatabase.houseCoffeeTable;

  @override
  Future<List<HouseCoffee>> fetchAll() async {
    final db = await _db;
    final list = await db.query(
      _table,
    );
    return list.map((e) => HouseCoffee.fromMap(e)).toList()
      ..sort((a, b) => sortCompare(a.uid, b.uid));
  }

  @override
  Future<List<HouseCoffee>> fetchByBeanId(int id) async {
    final db = await _db;
    final list = await db.query(
      _table,
      where: '$beanIdKey = ?',
      whereArgs: <dynamic>[
        id,
      ],
    );
    return list.map((e) => HouseCoffee.fromMap(e)).toList()
      ..sort((a, b) => sortCompare(a.uid, b.uid));
  }

  @override
  Future<List<HouseCoffee>> fetchFavorite() async {
    final db = await _db;
    final list = await db.query(
      _table,
      where: '$isFavoriteKey = 1',
    );
    return list.map((e) => HouseCoffee.fromMap(e)).toList()
      ..sort((a, b) => sortCompare(a.uid, b.uid));
  }

  @override
  Future<HouseCoffee> fetchByUid(int uid) async {
    final db = await _db;
    final mapList = await db.query(
      _table,
      where: '$uidKey = ?',
      whereArgs: <dynamic>[
        uid,
      ],
    );
    final list = mapList.map((e) => HouseCoffee.fromMap(e)).toList();
    return (list.isNotEmpty) ? list[0] : null;
  }

  @override
  Future<int> insert(HouseCoffee coffee) async {
    final db = await _db;
    return db.insert(
      _table,
      coffee.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> delete(HouseCoffee coffee) async {
    if (coffee.imageUri != null) {
      try {
        (await getLocalFile(coffee.imageUri)).deleteSync();
      } catch (e) {
        log('Catch exception when deleting image: $e');
      }
    }
    final db = await _db;
    return db.delete(
      _table,
      where: '$uidKey = ?',
      whereArgs: <dynamic>[
        coffee.uid,
      ],
    );
  }

  @override
  Future<int> update(HouseCoffee coffee) async {
    final db = await _db;
    return db.update(
      _table,
      coffee.toMap(),
      where: '$uidKey = ?',
      whereArgs: <dynamic>[
        coffee.uid,
      ],
    );
  }
}
