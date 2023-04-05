import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  Future<Database> openDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'data.db');
    await deleteDatabase(path);
    Database db = await openDatabase(path, version: 1, onCreate: createTables);

    return db;
  }

  createTables(Database db, int version) async {
    await db.execute('CREATE TABLE user IF NOT EXISTS(token TEXT)');
  }
}
