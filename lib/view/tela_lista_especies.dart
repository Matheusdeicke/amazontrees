import 'package:amazontrees/view/tela_info_arvores.dart';
import 'package:flutter/material.dart';
import 'package:amazontrees/utils/colors.dart';

class TelaListaEspecies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Lista de Espécies'),
        backgroundColor: AppColors.secondaryColor,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildEspecieTile(context, 'Pau Brasil', 'Uma árvore nativa do Brasil.', 'assets/images/pau_brasil.png'),
            _buildEspecieTile(context, 'Cajueiro', 'Árvore que produz caju.', 'assets/images/cajueiro.png'),
            _buildEspecieTile(context, 'Andiroba', 'Árvore conhecida por seu óleo.', 'assets/images/andiroba.png'),
            // Adicione mais espécies conforme necessário
          ],
        ),
      ),
    );
  }

  Widget _buildEspecieTile(BuildContext context, String nome, String descricao, String imagePath) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Image.asset(
          imagePath,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(nome),
        subtitle: Text(descricao),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // Navegar para a tela de detalhes da árvore
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaInfoArvores(
                nome: nome,
                descricao: descricao,
                imagePath: imagePath,
              ),
            ),
          );
        },
      ),
    );
  }
}