import 'package:sqflite/sqflite.dart';

import '../models/game.dart';
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

  Future<int?> insertData(table, data) async {
    var connection = await database;
    var res = await connection?.insert(table, data);
    return res;
  }

  readData(table) async {
			var connection = await database;
			return await connection?.query(table);
	}

  readDataRaw(query) async {
			var connection = await database;
			return await connection?.rawQuery(query);
	}

  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }
  
  updateData(table, data) async {
    var connection = await database;
    return await connection?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }

  getCurrentGame() async {
    var connection = await database;
    var res = await connection?.query('games', where: 'end_date is null', orderBy: 'id desc', limit: 1);
    return res!.isNotEmpty ? Game.fromMap(res.first) : null ;
  }
}