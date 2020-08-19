import 'package:coffee_life_manager/model/cafe.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/cafe_dao.dart';
import 'package:coffee_life_manager/repository/sql_database.dart';
import 'package:sqflite/sqflite.dart';

import '../../../constant_string.dart';

class CafeDaoImpl implements CafeDao {
  final _db = SqlDatabase().database;
  final _table = SqlDatabase.cafeTable;

  @override
  Future<List<Cafe>> fetchAll() async {
    final db = await _db;
    final list = await db.query(
      _table,
    );
    return list.map((e) => Cafe.fromMap(e)).toList();
  }

  @override
  Future<List<Cafe>> fetchFavorite() async {
    final db = await _db;
    final list = await db.query(
      _table,
      where: '$isFavoriteKey = 1',
    );
    return list.map((e) => Cafe.fromMap(e)).toList();
  }

  @override
  Future<Cafe> fetchByUid(int uid) async {
    final db = await _db;
    final mapList = await db.query(
      _table,
      where: '$uidKey = ?',
      whereArgs: <dynamic>[
        uid,
      ],
    );
    final list = mapList.map((e) => Cafe.fromMap(e)).toList();
    return (list.isNotEmpty) ? list[0] : null;
  }

  @override
  Future<int> insert(Cafe cafe) async {
    final db = await _db;
    return db.insert(
      _table,
      cafe.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> delete(Cafe cafe) async {
    final db = await _db;
    return db.delete(
      _table,
      where: '$uidKey = ?',
      whereArgs: <dynamic>[
        cafe.uid,
      ],
    );
  }

  @override
  Future<int> update(Cafe cafe) async {
    final db = await _db;
    return db.update(
      _table,
      cafe.toMap(),
      where: '$uidKey = ?',
      whereArgs: <dynamic>[
        cafe.uid,
      ],
    );
  }
}