import 'dart:developer';

import 'package:coffee_life_manager/constant_string.dart';
import 'package:coffee_life_manager/function/get_file.dart';
import 'package:coffee_life_manager/function/sort_compare.dart';
import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/bean_dao.dart';
import 'package:sqflite/sqflite.dart';

import '../../sql_database.dart';

class BeanDaoImpl implements BeanDao {
  final _db = SqlDatabase().database;
  static const _table = SqlDatabase.beanTable;

  @override
  Future<List<Bean>> fetchAll() async {
    final db = await _db;
    final list = await db.query(
      _table,
    );
    return list.map((e) => Bean.fromMap(e)).toList()
      ..sort((a, b) => sortCompare(a.uid, b.uid));
  }

  @override
  Future<List<Bean>> fetchFavorite() async {
    final db = await _db;
    final list = await db.query(
      _table,
      where: '$isFavoriteKey = 1',
    );
    return list.map((e) => Bean.fromMap(e)).toList()
      ..sort((a, b) => sortCompare(a.uid, b.uid));
  }

  @override
  Future<List<Bean>> fetchByCafeId(int cafeId) async {
    final db = await _db;
    final list = await db.query(
      _table,
      where: '$cafeIdKey = ?',
      whereArgs: <dynamic>[
        cafeId,
      ],
    );
    return list.map((e) => Bean.fromMap(e)).toList()
      ..sort((a, b) => sortCompare(a.uid, b.uid));
  }

  @override
  Future<Bean> fetchByUid(int uid) async {
    final db = await _db;
    final mapList = await db.query(
      _table,
      where: '$uidKey = ?',
      whereArgs: <dynamic>[
        uid,
      ],
    );
    final list = mapList.map((e) => Bean.fromMap(e)).toList();
    return (list.isNotEmpty) ? list[0] : null;
  }

  @override
  Future<int> insert(Bean bean) async {
    final db = await _db;
    return db.insert(
      _table,
      bean.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> delete(Bean bean) async {
    if (bean.imageUri != null) {
      try {
        (await getLocalFile(bean.imageUri)).deleteSync();
      } catch (e) {
        log('Catch exception when deleting image: $e');
      }
    }

    final db = await _db;
    return db.delete(
      _table,
      where: '$uidKey = ?',
      whereArgs: <dynamic>[
        bean.uid,
      ],
    );
  }

  @override
  Future<int> update(Bean bean) async {
    final db = await _db;
    return db.update(
      _table,
      bean.toMap(),
      where: '$uidKey = ?',
      whereArgs: <dynamic>[
        bean.uid,
      ],
    );
  }
}
