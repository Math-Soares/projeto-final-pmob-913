import 'package:albedo/domain/warning.dart';
import 'package:dio/dio.dart';

class WarningApi {
  final dio = Dio();
  String baseUrl = 'https://my-json-server.typicode.com/Math-Soares/fake_api';

  Future<List<Warning>> listWarnings() async {
    try {
      final response = await dio.get('$baseUrl/warnings');

      List<Warning> lista = [];

      if (response.statusCode == 200) {
        for (var json in response.data) {
          Warning warning = Warning.fromJson(json);
          lista.add(warning);
        }
      }

      return lista;
    } catch (e) {
      throw Exception('Erro ao carregar warnings: $e');
    }
  }
}
