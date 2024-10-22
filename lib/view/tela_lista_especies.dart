import 'package:flutter/material.dart';
import 'package:amazontrees/utils/colors.dart';

class TelaListaEspecies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Espécies'),
        backgroundColor: AppColors.secondaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Adicionar lógica para adicionar nova espécie
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildEspecieTile('Pau Brasil', 'Uma árvore nativa do Brasil.', 'assets/images/pau_brasil.png'),
            _buildEspecieTile('Cajueiro', 'Árvore que produz caju.', 'assets/images/cajueiro.png'),
            _buildEspecieTile('Andiroba', 'Árvore conhecida por seu óleo.', 'assets/images/andiroba.png'),
            // Adicione mais espécies conforme necessário
          ],
        ),
      ),
    );
  }

  Widget _buildEspecieTile(String nome, String descricao, String imagePath) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Image.asset(
          imagePath,
          width: 50,  // Ajuste a largura conforme necessário
          height: 50, // Ajuste a altura conforme necessário
          fit: BoxFit.cover,
        ),
        title: Text(nome),
        subtitle: Text(descricao),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // Lógica para visualizar detalhes da espécie
        },
      ),
    );
  }
}
