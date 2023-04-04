import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper{

  Future<Database> setDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_uno');
    var database = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async{
    String sqlGames = """CREATE TABLE games(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      start_date TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
      end_date TEXT,
      score_to_win INTEGER,
      winner_id INTEGER,
      winner_score INTEGER,
      created_date TEXT NOT NULL,
      updated_date TEXT NOT NULL
    )""";

    String sqlPlayers = """CREATE TABLE players(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT NOT NULL,      
      created_date TEXT NOT NULL,
      updated_date TEXT NOT NULL
    )""";

    String sqlRounds = """CREATE TABLE rounds(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      game_id INTEGER,
      player_id INTEGER,
      round_number INTEGER,
      score INTEGER,      
      created_date TEXT NOT NULL,
      updated_date TEXT NOT NULL,
      FOREIGN KEY(game_id) REFERENCES games(id),
      FOREIGN KEY(player_id) REFERENCES players(id)
    )"""; 

    String sqlGamePlayers = """CREATE TABLE game_players(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      game_id INTEGER,
      player_id INTEGER,      
      created_date TEXT NOT NULL,
      updated_date TEXT NOT NULL,
      FOREIGN KEY(game_id) REFERENCES games(id),
      FOREIGN KEY(player_id) REFERENCES players(id)
    )"""; 

    await database.execute(sqlGames);
    await database.execute(sqlPlayers);
    await database.execute(sqlRounds);
    await database.execute(sqlGamePlayers);
  }
}