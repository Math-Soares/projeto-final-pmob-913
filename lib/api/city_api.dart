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
          'current':
              'temperature_2m,apparent_temperature,relative_humidity_2m,weather_code,wind_speed_10m,uv_index,pressure_msl,visibility',
          'daily':
              'weather_code,temperature_2m_max,temperature_2m_min,precipitation_probability_max',
          'timezone': 'auto',
        },
      );

    if (response.statusCode != 200) {
      return null;
    }
    final current = response.data['current'];
    final daily = response.data['daily'];

    final int weatherCode = current['weather_code'] ?? 0;
    String condicaoTexto = 'Indefinido';
    if (weatherCode == 0) {
      condicaoTexto = 'Céu limpo';
    } else if (weatherCode == 1 || weatherCode == 2) {
      condicaoTexto = 'Parcialmente nublado';
    } else if (weatherCode == 3) {
      condicaoTexto = 'Nublado';
    } else if (weatherCode == 45 || weatherCode == 48) {
      condicaoTexto = 'Neblina';
    } else if (weatherCode >= 51 && weatherCode <= 57) {
      condicaoTexto = 'Garoa';
    } else if (weatherCode >= 61 && weatherCode <= 67) {
      condicaoTexto = 'Chuva';
    } else if (weatherCode >= 71 && weatherCode <= 77) {
      condicaoTexto = 'Neve';
    } else if (weatherCode == 80 || weatherCode == 81 || weatherCode == 82) {
      condicaoTexto = 'Pancadas de chuva';
    } else if (weatherCode == 85 || weatherCode == 86) {
      condicaoTexto = 'Pancadas de neve';
    } else if (weatherCode == 95 || weatherCode == 96 || weatherCode == 99) {
      condicaoTexto = 'Trovoada';
    }

    return City(
      name: location[0]['name'] ?? cityName,
      state: location[0]['state'] ?? '',
      degrees: (current['temperature_2m'] as num).round(),
      min: (daily['temperature_2m_min'][0] as num).round(),
      max: (daily['temperature_2m_max'][0] as num).round(),
      uv: ((current['uv_index'] as num?) ?? 0).round(),
      pre: ((daily['precipitation_probability_max']?[0] as num?) ?? 0).round(),
      condition: condicaoTexto,
      humidity: (current['relative_humidity_2m'] as num).round(),
      wind: (current['wind_speed_10m'] as num).toDouble(),
      feelsLike: (current['apparent_temperature'] as num).round(),
      pressure: (current['pressure_msl'] as num).toDouble(),
      favorite: favorite,
      visibility: ((current['visibility'] as num?) ?? 0) / 1000,
      isMyLocation: isMyLocation,
    );
    } catch (e) {
      return null;
    }
  }
}
