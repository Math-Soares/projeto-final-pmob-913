import 'package:albedo/db/db_helper.dart';
import 'package:albedo/domain/user.dart';
import 'package:sqflite/sqlite_api.dart';

class UserDao {
  Future<bool> login(String username, String password) async {
    Database db = await DBHelper().initDB();
    String sql = '''
      SELECT *
      FROM USER
      WHERE username = ? AND password = ?;    
    ''';

    var result = await db.rawQuery(sql, [username, password]);
    return result.isNotEmpty;
  }

  saveUser(User user) async {
    Database db = await DBHelper().initDB();
    db.insert('USER', user.toJson());
  }
}

/*
import 'package:albedo/api/users_api.dart';
import 'package:sqflite/sqlite_api.dart';

import '../domain/user.dart';
import 'db_helper.dart';

class UserDao {
  Future<bool> login(String username, String password) async {
    List<User> listUsers = await UsersApi().listarUsuarios();

    for (var user in listUsers) {
      if (user.username == username && user.password == password) {
        return true;
      }
    }
    return false;
  }

  void saveUser(User user) async {
    Database db = await DBHelper().initDB();
    db.insert('USER', user.toJson());
  }
}
*/