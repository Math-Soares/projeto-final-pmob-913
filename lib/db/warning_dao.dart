import 'package:primeiroaplicativo/domain/warning.dart';
import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';

class WarningDao {
  Future<List<Warning>> listWarnings() async {
    Database db = await DBHelper().initDB();

    var result = await db.rawQuery('SELECT * FROM WARNING');

    // linha p/ linha
    List<Warning> lista = [];
    for (var json in result) {
      // Metodo Padrão
      // City City = City(
      //   urlImagem: json['urlImagem'],
      //   dates: json['dates'],
      //   local: '',
      //   host: '',
      //   total: '',
      // );

      Warning warning = Warning.fromJson(json);
      lista.add(warning);
    }

    return lista;
  }
}
