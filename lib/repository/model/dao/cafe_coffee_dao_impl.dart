import 'dart:developer';

import 'package:coffee_life_manager/function/get_file.dart';
import 'package:coffee_life_manager/model/cafe_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/cafe_coffee_dao.dart';
import 'package:sqflite/sqflite.dart';

import '../../../constant_string.dart';
import '../../sql_database.dart';

class CafeCoffeeDaoImpl implements CafeCoffeeDao {
  final _db = SqlDatabase().database;
  static const _table = SqlDatabase.cafeCoffeeTable;

  @override
  Future<List<CafeCoffee>> fetchAll() async {
    final db = await _db;
    final list = await db.query(
      _table,
    );
    return list.map((e) => CafeCoffee.fromMap(e)).toList()
      ..sort((a, b) => b.uid - a.uid);
  }

  @override
  Future<List<CafeCoffee>> fetchByCafeId(int cafeId) async {
    if (cafeId == null) return [];
    final db = await _db;
    final list = await db.query(
      _table,
      where: '$cafeIdKey = ?',
      whereArgs: <dynamic>[
        cafeId,
      ],
    );
    return list.map((e) => CafeCoffee.fromMap(e)).toList()
      ..sort((a, b) => b.uid - a.uid);
  }

  @override
  Future<List<CafeCoffee>> fetchFavorite() async {
    final db = await _db;
    final list = await db.query(
      _table,
      where: '$isFavoriteKey = 1',
    );
    return list.map((e) => CafeCoffee.fromMap(e)).toList()
      ..sort((a, b) => b.uid - a.uid);
  }

  @override
  Future<CafeCoffee> fetchByUid(int uid) async {
    final db = await _db;
    final mapList = await db.query(
      _table,
      where: '$uidKey = ?',
      whereArgs: <dynamic>[
        uid,
      ],
    );
    final list = mapList.map((e) => CafeCoffee.fromMap(e)).toList();
    return (list.isNotEmpty) ? list[0] : null;
  }

  @override
  Future<int> insert(CafeCoffee coffee) async {
    final db = await _db;
    return db.insert(
      _table,
      coffee.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> delete(CafeCoffee coffee) async {
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
  Future<int> update(CafeCoffee coffee) async {
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
