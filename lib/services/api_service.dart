import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:amazontrees/model/Especies.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ApiService {
  static const String apiUrl = 'http://10.0.2.2:8000/api/arvores';

  static Future<List<Arvore>> fetchEspecies() async {
    try {
      final response = await http
          .get(Uri.parse(apiUrl))
          .timeout(Duration(seconds: 10), onTimeout: () {
        throw Exception("A requisição demorou muito. Verifique sua conexão.");
      });

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['data'] is List) {
          return (jsonResponse['data'] as List)
              .map((json) => Arvore.fromJson(json))
              .toList();
        } else {
          throw Exception("Resposta inesperada da API.");
        }
      } else {
        throw Exception(
            "Erro ao buscar espécies: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return [];
    }
  }
}