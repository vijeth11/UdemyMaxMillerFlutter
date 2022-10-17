import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    print(dbPath);
    return sql.openDatabase(path.join(dbPath, 'kedoFood.db'),
        onCreate: (db, version) async {
      await db.execute('''
          create table cart_items(itemId TEXT  PRIMAY KEY, itemName TEXT, itemImage TEXT, quantity INT, itemCost REAL, categoryName TEXT)
          ''');
      return db.execute('''
          create table shipping_address(deliveryUserName TEXT,deliveryUserPhone TEXT,deliveryUserEmail TEXT,deliveryAddress TEXT,deliveryZipCode TEXT,deliveryCity TEXT,deliveryCountry TEXT)
      ''');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<void> update(String table, Map<String, Object> data,
      String? where, List<Object?>? whereArgs) async {
    final db = await DBHelper.database();
    await db.update(table, data, where: where, whereArgs: whereArgs);
  }

  static Future<void> remove(
      String table, String? where, List<Object?>? whereArgs) async {
    final db = await DBHelper.database();
    await db.delete(table, where: where, whereArgs: whereArgs);
  }

  static Future<List<Map<String, Object?>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<void> RemoveAll(String table) async {
    final db = await DBHelper.database();
    await db.delete(table);
  }
}
