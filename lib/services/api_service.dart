import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../model/Especies.dart';

class ApiService {
  static final Logger _logger = Logger();

  static Future<List<Arvore>> fetchEspecies(BuildContext context) async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/arvores'));

      // Log do código de status da resposta
      _logger.i('Status Code: ${response.statusCode}');
      // Log do corpo da resposta
      _logger.d('Body da resposta: ${response.body}');

      if (response.statusCode == 200) {
        // Decodifica o JSON principal
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Verifica se há uma chave "data" contendo a lista
        if (jsonData.containsKey('data')) {
          final List<dynamic> dataList = jsonData['data'];

          // Certifique-se de que dataList não é null ou vazia
          if (dataList.isEmpty) {
            _logger.w('Nenhuma espécie encontrada na API.');
            return [];
          }

          // Converte cada item da lista para o modelo Arvore
          return dataList.map((item) => Arvore.fromJson(item)).toList();
        } else {
          throw Exception('Chave "data" ausente na resposta da API.');
        }
      } else {
        throw Exception('Erro ao carregar dados: ${response.statusCode}');
      }
    } catch (e) {
      _logger.e('Erro em fetchEspecies: $e');
      throw Exception('Erro ao carregar espécies: $e');
    }
  }
}
