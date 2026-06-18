import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // se usar o await -> async e o Future<TipoDeRetorno>
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'previsao.db';

    // Criar o path (caminho) do db (banco de dados)
    String dbPath = join(path, dbName);

    // Criar ou Obter o Banco de Dados
    Database db = await openDatabase(dbPath, version: 1, onCreate: onCreateDB);

    return db;
  }

  Future<void> onCreateDB(Database db, int version) async {
    String sql = '''CREATE TABLE CITY (
        id         INTEGER PRIMARY KEY AUTOINCREMENT,
        name       TEXT    NOT NULL,
        state      TEXT    NOT NULL,
        favorite   INTEGER NOT NULL CHECK (favorite IN (0, 1)),
        degrees    INTEGER NOT NULL,
        min        INTEGER NOT NULL,
        max        INTEGER NOT NULL,
        uv         INTEGER NOT NULL,
        pre        INTEGER NOT NULL,
        condition  TEXT    NOT NULL,
        humidity   INTEGER NOT NULL,
        wind       REAL    NOT NULL,
        feelsLike  INTEGER NOT NULL,
        pressure   REAL    NOT NULL,
        visibility REAL    NOT NULL
      );''';
    await db.execute(sql);

    sql = '''CREATE TABLE WARNING (
        id          INTEGER PRIMARY KEY AUTOINCREMENT,
        title       TEXT    NOT NULL,
        description TEXT    NOT NULL,
        level       INTEGER NOT NULL
      );''';
    await db.execute(sql);

    sql =
        "INSERT INTO CITY (name, state, favorite, degrees, min, max, uv, pre, condition, humidity, wind, feelsLike, pressure, visibility) VALUES ('Maceió', 'AL', 1, 32, 28, 35, 8, 20, 'Parcialmente nublado', 78, 17.5, 33, 1012.0, 10.0);";
    await db.execute(sql);

    sql =
        "INSERT INTO CITY (name, state, favorite, degrees, min, max, uv, pre, condition, humidity, wind, feelsLike, pressure, visibility) VALUES ('São Paulo', 'SP', 1, 22, 15, 26, 5, 10, 'Nublado', 80, 12.0, 22, 1016.0, 9.0);";
    await db.execute(sql);

    sql =
        "INSERT INTO CITY (name, state, favorite, degrees, min, max, uv, pre, condition, humidity, wind, feelsLike, pressure, visibility) VALUES ('Rio de Janeiro', 'RJ', 1, 28, 22, 32, 7, 0, 'Ensolarado', 70, 15.0, 30, 1012.0, 10.0);";
    await db.execute(sql);

    sql =
        "INSERT INTO CITY (name, state, favorite, degrees, min, max, uv, pre, condition, humidity, wind, feelsLike, pressure, visibility) VALUES ('Fortaleza', 'CE', 0, 30, 26, 32, 9, 40, 'Chuva passageira', 75, 22.0, 34, 1010.0, 10.0);";
    await db.execute(sql);

    sql =
        "INSERT INTO CITY (name, state, favorite, degrees, min, max, uv, pre, condition, humidity, wind, feelsLike, pressure, visibility) VALUES ('Brasília', 'DF', 0, 25, 18, 28, 8, 0, 'Céu limpo', 45, 10.0, 25, 1014.0, 10.0);";
    await db.execute(sql);

    sql =
        "INSERT INTO CITY (name, state, favorite, degrees, min, max, uv, pre, condition, humidity, wind, feelsLike, pressure, visibility) VALUES ('Salvador', 'BA', 0, 29, 24, 31, 8, 30, 'Parcialmente nublado', 78, 18.0, 32, 1011.0, 10.0);";
    await db.execute(sql);

    sql =
        "INSERT INTO WARNING (title, description, level) VALUES ('Tempestade Severa', 'Ventos de até 90km/h previstos para essa tarde. Evite áreas abertas.', 3);";
    await db.execute(sql);

    sql =
        "INSERT INTO WARNING (title, description, level) VALUES ( 'Alto Índice UV', 'UV entre 8-10 amanhã. Use protetor solar e evite sol entre 10h-16h.', 2);";
    await db.execute(sql);

    sql =
        "INSERT INTO WARNING (title, description, level) VALUES ('Melhora no fim de semana', 'Sábado e domingo com sol e baixa umidade. Ótimo para atividades ao ar livre.', 1);";
    await db.execute(sql);
  }
}
