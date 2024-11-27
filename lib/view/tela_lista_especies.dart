import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/toast.dart';
import '../database/database_helper.dart';
import '../model/Especies.dart';
import 'tela_info_arvores.dart';

class TelaListaEspecies extends StatefulWidget {
  @override
  _TelaListaEspeciesState createState() => _TelaListaEspeciesState();
}

class _TelaListaEspeciesState extends State<TelaListaEspecies> {
  final dbHelper = DatabaseHelper.instance; // Instância do DatabaseHelper
  List<Arvore> especies = [];
  List<Arvore> filteredEspecies = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _carregarEspecies();
  }

  Future<void> _carregarEspecies() async {
    try {
      // Busca todas as árvores do banco
      final especiesSalvas = await dbHelper.fetchArvores();
      setState(() {
        especies = especiesSalvas;
        filteredEspecies = especiesSalvas; // Inicializa com todas as espécies
      });
    } catch (e) {
      ToastUtils.showToast(
        context: context,
        message: 'Erro ao carregar espécies: $e',
        backgroundColor: Colors.red,
      );
    }
  }

  void _filterEspecies(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredEspecies = especies;
      } else {
        filteredEspecies = especies
            .where((especie) =>
            especie.nomePopular.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          SizedBox(height: 40),
          // Campo de Pesquisa
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: _filterEspecies,
              decoration: InputDecoration(
                hintText: 'Pesquisar por nome popular...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.secondaryColor,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.green,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          // Lista de Espécies
          Expanded(
            child: filteredEspecies.isEmpty
                ? Center(
              child: Text(
                'Nenhuma espécie encontrada.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
                : ListView.builder(
              itemCount: filteredEspecies.length,
              itemBuilder: (context, index) {
                final especie = filteredEspecies[index];
                return EspecieTile(especie: especie);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EspecieTile extends StatelessWidget {
  final Arvore especie;

  EspecieTile({required this.especie});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: especie.imagemUrl.isNotEmpty
              ? Image.network(
            especie.imagemUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/error_image.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              );
            },
          )
              : Image.asset(
            'assets/images/error_image.png',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          especie.nomePopular,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        subtitle: Text(
          especie.descricaoBotanica,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(Icons.arrow_forward, color: AppColors.secondaryColor),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaInfoArvores(arvore: especie),
            ),
          );
        },
      ),
    );
  }
}
