import 'package:albedo/domain/user.dart';
import 'package:dio/dio.dart';

class UsersApi {
  final dio = Dio();
  String baseUrl = 'https://my-json-server.typicode.com/Math-Soares/fake_api';

  Future<List<User>> listarUsuarios() async {
    try {
      final response = await dio.get('$baseUrl/users');

      List<User> lista = [];

      if (response.statusCode == 200) {
        for (var json in response.data) {
          User user = User.fromJson(json);
          lista.add(user);
        }
      }

      return lista;
    } catch (e) {
      throw Exception('Erro ao carregar usuários: $e');
    }
  }
}
