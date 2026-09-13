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
