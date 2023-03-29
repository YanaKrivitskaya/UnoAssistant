import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';

class UnoRepository{
  late DbHelper _dbHelper;

  UnoRepository(){
    _dbHelper = DbHelper();
  }

  static Database? _database;

  Future<Database?>get database async{
    if(_database != null) {
      return _database;
    } else{
      _database = await _dbHelper.setDatabase();
      return _database; 
    }
  }

  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  readData(table) async {
			var connection = await database;
			return await connection?.query(table);
	}

  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }
  updateData(table, data) async {
    var connection = await database;
    return await connection
    ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }
  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }
}