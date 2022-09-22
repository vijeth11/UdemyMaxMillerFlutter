import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    print(dbPath);
    return sql.openDatabase(path.join(dbPath, 'cartitem.db'),
        onCreate: (db, version) {
      return db.execute(
          'create table cart_items(itemId TEXT  PRIMAY KEY, itemName TEXT, itemImage TEXT, quantity INT, itemCost REAL, categoryName TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<void> update(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db
        .update(table, data, where: 'itemId = ?', whereArgs: [data['itemId']]);
  }

  static Future<void> remove(String table, String itemId) async {
    final db = await DBHelper.database();
    await db.delete(table, where: 'itemId = ?', whereArgs: [itemId]);
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
