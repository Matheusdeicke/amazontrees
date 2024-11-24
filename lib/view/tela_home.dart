import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/api_service.dart';
import '../model/Especies.dart';
import '../database/database_helper.dart';
import '../utils/colors.dart';

class TelaHome extends StatefulWidget {
  @override
  _TelaHomeState createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  final dbHelper = DatabaseHelper.instance;
  bool isSyncing = false; // Para controlar o estado de sincronização

  // Sincroniza os dados da API e os salva no banco de dados
  Future<void> sincronizarDados() async {
    setState(() {
      isSyncing = true; // Iniciando sincronização
    });

    try {
      Fluttertoast.showToast(
        msg: "Sincronizando espécies...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
      );

      // Busca os dados da API
      final especiesApi = await ApiService.fetchEspecies(context);

      // Limpa o banco e insere os novos dados
      await dbHelper.clearArvore();
      for (var especie in especiesApi) {
        await dbHelper.insertArvore(especie);
      }

      // Atualiza a lista local com os dados sincronizados
      final count = await carregarEspecies();

      Fluttertoast.showToast(
        msg: "Sincronização concluída com sucesso! Total de árvores: $count",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Erro ao sincronizar espécies: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      setState(() {
        isSyncing = false; // Finalizando sincronização
      });
    }
  }

  // Carrega os dados salvos no banco de dados e retorna a quantidade
  Future<int> carregarEspecies() async {
    try {
      final especiesSalvas = await dbHelper.fetchArvores(); // Agora retorna uma lista
      return especiesSalvas.length; // Retorna a contagem
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Erro ao carregar espécies: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Tela Home'),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Botão de Sincronização
            ElevatedButton.icon(
              onPressed: isSyncing ? null : sincronizarDados,
              icon: Icon(isSyncing ? Icons.sync : Icons.cloud_download),
              label: Text(isSyncing ? "Sincronizando..." : "Sincronizar Espécies"),
              style: ElevatedButton.styleFrom(
                backgroundColor: isSyncing ? AppColors.secondaryColor : AppColors.selectedNavigationBar,
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
