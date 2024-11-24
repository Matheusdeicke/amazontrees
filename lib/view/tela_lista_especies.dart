import 'package:amazontrees/view/tela_info_arvores.dart';
import 'package:flutter/material.dart';
import 'package:amazontrees/utils/colors.dart';
import 'package:amazontrees/services/api_service.dart';
import '../model/Especies.dart';

class TelaListaEspecies extends StatefulWidget {
  @override
  _TelaListaEspeciesState createState() => _TelaListaEspeciesState();
}

class _TelaListaEspeciesState extends State<TelaListaEspecies> {
  late Future<List<Arvore>> especiesFuture;

  @override
  void initState() {
    super.initState();
    especiesFuture = ApiService.fetchEspecies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Lista de Espécies'),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: FutureBuilder<List<Arvore>>(
        future: especiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma espécie encontrada'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final especie = snapshot.data![index];
                return EspecieTile(especie: especie);
              },
            ),
          );
        },
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
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Image.asset(
          especie.image_url ?? 'assets/images/error_image.png',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(especie.nomePopular),
        subtitle: Text(especie.descricaoBotanica),
        trailing: Icon(Icons.arrow_forward),
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
