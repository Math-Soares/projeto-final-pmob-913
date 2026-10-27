import 'package:albedo/domain/city.dart';
import 'package:albedo/domain/city_summary.dart';
import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';

class CityDao {
  Future<List<CitySummary>> listCities() async {
    Database db = await DBHelper().initDB();

    var result = await db.rawQuery('SELECT * FROM CITY');

    // linha p/ linha
    List<CitySummary> lista = [];
    for (var json in result) {
      // Metodo Padrão
      // City City = City(
      //   urlImagem: json['urlImagem'],
      //   dates: json['dates'],
      //   local: '',
      //   host: '',
      //   total: '',
      // );

      CitySummary city = CitySummary.fromJson(json);
      lista.add(city);
    }

    return lista;
  }

  Future<List<City>> listFavoritesCities() async {
    Database db = await DBHelper().initDB();

    var result = await db.rawQuery('SELECT * FROM CITY WHERE favorite = 1');

    // linha p/ linha
    List<City> lista = [];
    for (var json in result) {
      // Metodo Padrão
      // City City = City(
      //   urlImagem: json['urlImagem'],
      //   dates: json['dates'],
      //   local: '',
      //   host: '',
      //   total: '',
      // );

      City city = City.fromJson(json);
      lista.add(city);
    }

    return lista;
  }

  Future<List<City>> listNonFavoritesCities() async {
    Database db = await DBHelper().initDB();

    var result = await db.rawQuery('SELECT * FROM CITY WHERE favorite = 0');

    // linha p/ linha
    List<City> lista = [];
    for (var json in result) {
      // Metodo Padrão
      // City City = City(
      //   urlImagem: json['urlImagem'],
      //   dates: json['dates'],
      //   local: '',
      //   host: '',
      //   total: '',
      // );

      City city = City.fromJson(json);
      lista.add(city);
    }

    return lista;
  }
}
