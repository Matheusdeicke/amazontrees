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
        backgroundColor: Colors.green,
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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Centraliza verticalmente o conteúdo
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza no eixo principal
          children: [
            // Box Circular com Imagem
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.green, // Cor de fundo da box
                shape: BoxShape.circle, // Formato circular
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/tree_logo.png',
                  fit: BoxFit.cover, // Faz a imagem ocupar toda a box circular
                ),
              ),
            ),
            SizedBox(height: 16), // Espaçamento entre a imagem e o botão
            // Botão de Sincronização
            ElevatedButton.icon(
              onPressed: isSyncing ? null : sincronizarDados,
              icon: Icon(isSyncing ? Icons.sync : Icons.cloud_download),
              label: Text(isSyncing ? "Sincronizando..." : "Sincronizar Espécies"),
              style: ElevatedButton.styleFrom(
                backgroundColor: isSyncing ? AppColors.secondaryColor : Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
