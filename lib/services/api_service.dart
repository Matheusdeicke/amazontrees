import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:amazontrees/model/Especies.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ApiService {
  static const String apiUrl = 'http://127.0.0.1:8000/api/arvores';

  static Future<List<Arvore>> fetchEspecies() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Certifique-se de que a chave "data" existe e é uma lista
        if (jsonResponse.containsKey('data') && jsonResponse['data'] is List) {
          final List<dynamic> data = jsonResponse['data'];
          return data.map((json) => Arvore.fromJson(json)).toList();
        } else {
          Fluttertoast.showToast(
            msg: "Erro: resposta inesperada da API.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          return [];
        }
      } else {
        Fluttertoast.showToast(
          msg: "Erro ao buscar espécies: ${response.statusCode}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return [];
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Erro ao buscar espécies: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return [];
    }
  }

}
