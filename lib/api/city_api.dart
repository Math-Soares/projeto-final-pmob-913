import 'package:albedo/domain/city.dart';
import 'package:dio/dio.dart';

class CityApi {
  final dio = Dio();
  String geocodingBaseUrl = 'https://geocoding-api.open-meteo.com/v1';
  String weatherBaseUrl = 'https://api.open-meteo.com/v1';

  Future<List<Map<String, dynamic>>> getCoordinatesCity(String cityName) async {
    List<Map<String, dynamic>> coordinates = [];
    final response = await dio.get(
      '$geocodingBaseUrl/search',
      queryParameters: {
        'name': cityName,
        'count': 1,
        'language': 'pt',
        'format': 'json',
      },
    );

    if (response.statusCode == 200) {
      final results = response.data['results'];

      if (results is! List || results.isEmpty) {
        return [];
      }

      coordinates = [
        {
          "name": results[0]['name'],
          "state": results[0]['admin1'],
          "latitude": results[0]['latitude'],
          "longitude": results[0]['longitude'],
        },
      ];
    }

    return coordinates;
  }

  Future<City?> fetchWeatherData(
    String cityName, {
    bool favorite = false,
    bool isMyLocation = false,
  }) async {
    try {
      final location = await getCoordinatesCity(cityName);

      if (location.isEmpty) {
        return null;
      }

      final response = await dio.get(
        '$weatherBaseUrl/forecast',
        queryParameters: {
          'latitude': location[0]['latitude'],
          'longitude': location[0]['longitude'],
          'current': 'temperature_2m,apparent_temperature,relative_humidity_2m,weather_code,wind_speed_10m,uv_index,pressure_msl,visibility',
          'daily': 'weather_code,temperature_2m_max,temperature_2m_min,precipitation_probability_max',
          'timezone': 'auto',
        },
      );

      if (response.statusCode != 200) {
        return null;
      }
      final current = response.data['current'];
      final daily = response.data['daily'];

      final int weatherCode = current['weather_code'] ?? 0;
      final String condicaoTexto = _conditionFromCode(weatherCode);

      return City.fromJson({
        'name': location[0]['name'] ?? cityName,
        'state': location[0]['state'] ?? '',
        'degrees': (current['temperature_2m'] as num).round(),
        'min': (daily['temperature_2m_min'][0] as num).round(),
        'max': (daily['temperature_2m_max'][0] as num).round(),
        'uv': ((current['uv_index'] as num?) ?? 0).round(),
        'pre': ((daily['precipitation_probability_max']?[0] as num?) ?? 0).round(),
        'condition': condicaoTexto,
        'humidity': (current['relative_humidity_2m'] as num).round(),
        'wind': (current['wind_speed_10m'] as num).toDouble(),
        'feelsLike': (current['apparent_temperature'] as num).round(),
        'pressure': (current['pressure_msl'] as num).toDouble(),
        'favorite': favorite ? 1 : 0,
        'visibility': ((current['visibility'] as num?) ?? 0) / 1000,
        'isMyLocation': isMyLocation ? 1 : 0,
      });
    } catch (e) {
      print('Erro ao buscar clima de $cityName: $e');
      return null;
    }
  }

  String _conditionFromCode(int code) {
    if (code == 0) return 'Céu limpo';
    if (code == 1 || code == 2) return 'Parcialmente nublado';
    if (code == 3) return 'Nublado';
    if (code == 45 || code == 48) return 'Neblina';
    if (code >= 51 && code <= 57) return 'Garoa';
    if (code >= 61 && code <= 67) return 'Chuva';
    if (code >= 71 && code <= 77) return 'Neve';
    if (code >= 80 && code <= 82) return 'Pancadas de chuva';
    if (code == 85 || code == 86) return 'Pancadas de neve';
    if (code == 95 || code == 96 || code == 99) return 'Trovoada';
    return 'Indefinido';
  }
}
