import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:amazontrees/model/Especies.dart';

class ApiService {
  static const String apiUrl = 'https://seu_backend_laravel.com/api/especies';

  static Future<List<Arvore>> fetchEspecies() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Arvore.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar dados');
    }
  }
}
