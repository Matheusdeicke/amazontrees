import 'package:flutter/material.dart';
import 'package:amazontrees/utils/colors.dart';

class TelaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de pesquisa
            TextField(
              decoration: InputDecoration(
                hintText: 'Digite uma espécie',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Botões de cadastrar árvores e árvores cadastradas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton(
                  context,
                  icon: Icons.add,
                  label: 'Cadastrar Árvores',
                  onPressed: () {
                    // Navegar para a tela de cadastro de árvores
                  },
                ),
                _buildActionButton(
                  context,
                  icon: Icons.cloud_done,
                  label: 'Árvores Cadastradas',
                  onPressed: () {
                    // Navegar para a tela de árvores cadastradas
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            // Seção de favoritos
            Text(
              'Favoritos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FavoritoCard('Pau Brasil', 'assets/images/pau_brasil.png'),
                  FavoritoCard('Cajueiro', 'assets/images/cajueiro.png'),
                  FavoritoCard('Andiroba', 'assets/images/andiroba.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class FavoritoCard extends StatelessWidget {
  final String nome;
  final String imagePath;

  FavoritoCard(this.nome, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(nome),
          ),
        ],
      ),
    );
  }
}
