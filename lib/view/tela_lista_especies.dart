import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../utils/colors.dart';
import '../utils/toast.dart';
import '../services/api_service.dart';
import '../model/Especies.dart';
import 'tela_info_arvores.dart';

class TelaListaEspecies extends StatefulWidget {
  @override
  _TelaListaEspeciesState createState() => _TelaListaEspeciesState();
}

class _TelaListaEspeciesState extends State<TelaListaEspecies> {
  late Future<List<Arvore>> especiesFuture;

  @override
  void initState() {
    super.initState();
    // Inicializa o Future ao carregar a tela
    especiesFuture = ApiService.fetchEspecies(context);
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
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ToastUtils.showToast(
                context: context,
                message: 'Erro ao carregar espécies: ${snapshot.error}',
                backgroundColor: Colors.red,
              );
            });
            return Center(child: Text('Erro ao carregar dados.'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ToastUtils.showToast(
                context: context,
                message: 'Nenhuma espécie encontrada.',
                backgroundColor: Colors.orange,
              );
            });
            return Center(child: Text('Nenhuma espécie encontrada.'));
          }

          // Lista de espécies carregada
          final especies = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: especies.length,
              itemBuilder: (context, index) {
                final especie = especies[index];
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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          especie.descricaoBotanica,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(Icons.arrow_forward, color: AppColors.secondaryColor),
        onTap: () {
          if (especie.nomePopular.isEmpty) {
            ToastUtils.showToast(
              context: context,
              message: 'Nome popular da espécie está vazio!',
              backgroundColor: Colors.orange,
            );
            return;
          }
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
