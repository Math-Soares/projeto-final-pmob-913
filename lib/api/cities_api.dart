import 'package:albedo/domain/city_summary.dart';
import 'package:dio/dio.dart';

class CitiesApi {
  final dio = Dio();
  String baseUrl = 'https://my-json-server.typicode.com/Math-Soares/fake_api';

  Future<List<CitySummary>> listCities() async {
    try {
      final response = await dio.get('$baseUrl/cities');

      List<CitySummary> lista = [];

      if (response.statusCode == 200) {
        for (var json in response.data) {
          CitySummary citySummary = CitySummary.fromJson(json);
          lista.add(citySummary);
        }
      }

      return lista;
    } catch (e) {
      throw Exception('Erro ao carregar cidades: $e');
    }
  }
}
