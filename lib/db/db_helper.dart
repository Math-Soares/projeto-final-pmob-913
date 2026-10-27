
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // Inicializar o banco de dados
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'previsao.db';

    // Criar o caminho do banco de dados
    String dbPath = join(path, dbName);

    // Criar ou obter o banco de dados
    Database db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: onCreateDB,
      onUpgrade: onUpgradeDB,
    );

    return db;
  }

  // Atualizar o banco de dados
  Future<void> onUpgradeDB(
      Database db,
      int oldVersion,
      int newVersion,
      ) async {
    await db.execute("DROP TABLE IF EXISTS WEEKLY_FORECAST;");
    await db.execute("DROP TABLE IF EXISTS WARNING;");
    await db.execute("DROP TABLE IF EXISTS CITY;");
    await db.execute("DROP TABLE IF EXISTS USER;");

    await onCreateDB(db, newVersion);
  }

  // Criar as tabelas e inserir os dados
  Future<void> onCreateDB(Database db, int version) async {
    String sql;

    // =====================================================
    // TABELA USER
    // =====================================================

    sql = '''CREATE TABLE USER (
        id       INTEGER NOT NULL UNIQUE,
        username TEXT PRIMARY KEY,
        password TEXT NOT NULL
    );''';

    await db.execute(sql);

    // =====================================================
    // TABELA CITY
    // =====================================================

    sql = '''CREATE TABLE CITY (
        id    INTEGER PRIMARY KEY AUTOINCREMENT,
        name  TEXT NOT NULL,
        state TEXT NOT NULL
    );''';

    await db.execute(sql);

    // =====================================================
    // TABELA WARNING
    // =====================================================

    sql = '''CREATE TABLE WARNING (
        id          INTEGER PRIMARY KEY AUTOINCREMENT,
        title       TEXT    NOT NULL,
        description TEXT    NOT NULL,
        level       INTEGER NOT NULL
    );''';

    await db.execute(sql);

    // =====================================================
    // TABELA WEEKLY_FORECAST
    // =====================================================

    sql = '''CREATE TABLE WEEKLY_FORECAST (
        id  INTEGER PRIMARY KEY AUTOINCREMENT,
        day TEXT    NOT NULL,
        min INTEGER NOT NULL,
        max INTEGER NOT NULL
    );''';

    await db.execute(sql);

    // =====================================================
    // INSERTS DA TABELA USER
    // =====================================================

    sql = '''INSERT INTO USER (id, username, password)
        VALUES (1, 'matheus', 'M@th3us*Pass2');''';

    await db.execute(sql);

    sql = '''INSERT INTO USER (id, username, password)
        VALUES (2, 'maycon', 'M@yc0n_Key3');''';

    await db.execute(sql);

    sql = '''INSERT INTO USER (id, username, password)
        VALUES (3, 'wecikly', 'W#c1kly!Access4');''';

    await db.execute(sql);

    sql = '''INSERT INTO USER (id, username, password)
        VALUES (4, 'arthur', 'Art#ur\$Code5');''';

    await db.execute(sql);

    // =====================================================
    // INSERTS DA TABELA CITY
    // =====================================================

    sql = '''INSERT INTO CITY (id, name, state)
        VALUES (1, 'São Paulo', 'SP');''';

    await db.execute(sql);

    sql = '''INSERT INTO CITY (id, name, state)
        VALUES (2, 'Rio de Janeiro', 'RJ');''';

    await db.execute(sql);

    sql = '''INSERT INTO CITY (id, name, state)
        VALUES (3, 'Brasília', 'DF');''';

    await db.execute(sql);

    sql = '''INSERT INTO CITY (id, name, state)
        VALUES (4, 'Salvador', 'BA');''';

    await db.execute(sql);

    sql = '''INSERT INTO CITY (id, name, state)
        VALUES (5, 'Fortaleza', 'CE');''';

    await db.execute(sql);

    sql = '''INSERT INTO CITY (id, name, state)
        VALUES (6, 'Belo Horizonte', 'MG');''';

    await db.execute(sql);

    sql = '''INSERT INTO CITY (id, name, state)
        VALUES (7, 'Manaus', 'AM');''';

    await db.execute(sql);

    sql = '''INSERT INTO CITY (id, name, state)
        VALUES (8, 'Curitiba', 'PR');''';

    await db.execute(sql);

    sql = '''INSERT INTO CITY (id, name, state)
        VALUES (9, 'Recife', 'PE');''';

    await db.execute(sql);

    sql = '''INSERT INTO CITY (id, name, state)
        VALUES (10, 'Goiânia', 'GO');''';

    await db.execute(sql);

    // =====================================================
    // INSERTS DA TABELA WARNING
    // =====================================================

    sql = '''INSERT INTO WARNING (id, title, description, level)
        VALUES (
          1,
          'Tempestade Severa',
          'Ventos de até 90km/h previstos para essa tarde. Evite áreas abertas.',
          3
        );''';

    await db.execute(sql);

    sql = '''INSERT INTO WARNING (id, title, description, level)
        VALUES (
          2,
          'Alto Índice UV',
          'UV entre 8-10 amanhã. Use protetor solar e evite sol entre 10h-16h.',
          2
        );''';

    await db.execute(sql);

    sql = '''INSERT INTO WARNING (id, title, description, level)
        VALUES (
          3,
          'Melhora no fim de semana',
          'Sábado e domingo com sol e baixa umidade. Ótimo para atividades ao ar livre.',
          1
        );''';

    await db.execute(sql);

    // =====================================================
    // INSERTS DA TABELA WEEKLY_FORECAST
    // =====================================================

    sql = '''INSERT INTO WEEKLY_FORECAST (day, min, max)
        VALUES ('Segunda-feira', 20, 31);''';

    await db.execute(sql);

    sql = '''INSERT INTO WEEKLY_FORECAST (day, min, max)
        VALUES ('Terça-feira', 21, 30);''';

    await db.execute(sql);

    sql = '''INSERT INTO WEEKLY_FORECAST (day, min, max)
        VALUES ('Quarta-feira', 19, 27);''';

    await db.execute(sql);

    sql = '''INSERT INTO WEEKLY_FORECAST (day, min, max)
        VALUES ('Quinta-feira', 18, 25);''';

    await db.execute(sql);

    sql = '''INSERT INTO WEEKLY_FORECAST (day, min, max)
        VALUES ('Sexta-feira', 18, 26);''';

    await db.execute(sql);

    sql = '''INSERT INTO WEEKLY_FORECAST (day, min, max)
        VALUES ('Sábado', 19, 29);''';

    await db.execute(sql);

    sql = '''INSERT INTO WEEKLY_FORECAST (day, min, max)
        VALUES ('Domingo', 20, 30);''';

    await db.execute(sql);
  }
}
