import 'package:coffee_life_manager/constant_string.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDatabase {
  factory SqlDatabase() => _cache ??= SqlDatabase._internal();

  SqlDatabase._internal() {
    database = _createDatabase();
  }

  Future<Database> database;

  static SqlDatabase _cache;
  static const cafeTable = 'cafeTable';
  static const cafeCoffeeTable = 'cafeCoffeeTable';
  static const houseCoffeeTable = 'houseCoffeeTable';
  static const beanTable = 'beanTable';

  Future<Database> _createDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'coffee_life_manager.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        _createCafeTable(db, version);
        _createCafeCoffeeTable(db, version);
        _createHouseCoffeeTable(db, version);
        _createBeanTable(db, version);
      },
    );
  }

  Future<void> _createCafeTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $cafeTable(
      $uidKey INTEGER PRIMARY KEY AUTOINCREMENT,
      $cafeNameKey TEXT,
      $mapUrlKey TEXT,
      $regularHolidayKey TEXT,
      $imageUriKey TEXT,
      $isFavoriteKey INTEGER
    );
    ''');
  }

  Future<void> _createCafeCoffeeTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $cafeCoffeeTable(
      $uidKey INTEGER PRIMARY KEY AUTOINCREMENT,
      $productNameKey TEXT,
      $priceKey INTEGER,
      $drinkDayKey TEXT,
      $rateKey TEXT,
      $cafeIdKey INTEGER,
      $memoKey TEXT,
      $imageUriKey TEXT,
      $isFavoriteKey INTEGER
    );
    ''');
  }

  Future<void> _createHouseCoffeeTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $houseCoffeeTable(
      $uidKey INTEGER PRIMARY KEY AUTOINCREMENT,
      $beanNameKey TEXT,
      $numOfCupsKey INTEGER,
      $grindKey INTEGER,
      $dripKey INTEGER,
      $roastKey INTEGER,
      $drinkDayKey TEXT,
      $rateKey TEXT,
      $beanIdKey INTEGER,
      $memoKey TEXT,
      $imageUriKey TEXT,
      $isFavoriteKey INTEGER
    );
    ''');
  }

  Future<void> _createBeanTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $beanTable(
      $uidKey INTEGER PRIMARY KEY AUTOINCREMENT,
      $beanNameKey TEXT,
      $remainingAmountKey INTEGER,
      $oneCupPerGramKey INTEGER,
      $roastKey INTEGER,
      $freshnessDateKey TEXT,
      $openTimeKey TEXT,
      $priceKey INTEGER,
      $rateKey TEXT,
      $shopIdKey INTEGER,
      $memoKey TEXT,
      $imageUriKey TEXT,
      $isFavoriteKey INTEGER
    );
    ''');
  }
}
