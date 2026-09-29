import 'package:albedo/domain/weekly_forecast.dart';
import 'package:dio/dio.dart';

class WeeklyForecastApi {
  final dio = Dio();

  String baseUrl = 'https://my-json-server.typicode.com/Math-Soares/fake_api';

  Future<List<WeeklyForecast>> listWeeklyForecast() async {
    try {
      final response = await dio.get('$baseUrl/weekly_forecast');

      List<WeeklyForecast> lista = [];

      if (response.statusCode == 200) {
        for (var json in response.data) {
          WeeklyForecast forecast =
          WeeklyForecast.fromJson(json);

          lista.add(forecast);
        }
      }

      return lista;
    } catch (e) {
      throw Exception('Erro ao carregar previsão: $e');
    }
  }
}