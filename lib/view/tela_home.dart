import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TelaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('AMAZONTREE'),
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
                Expanded(
                  child: _buildActionButton(
                    context,
                    icon: Icons.cloud_done,
                    label: 'Árvores Cadastradas',
                    onPressed: () {
                      // Navegar para a tela de árvores cadastradas
                    },
                  ),
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

            SizedBox(
              height: 140, // Define a altura da ListView
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: favoritos.length, // Quantidade de itens na lista
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 3, // Dividido por 3 para mostrar 3 por vez
                    child: FavoritoCard(
                      favoritos[index]['nome']!,
                      favoritos[index]['imagePath']!,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Widget _buildActionButton(BuildContext context,
    {required IconData icon, required String label, required VoidCallback onPressed}) {
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

// Lista de árvores favoritas (exemplo)
final List<Map<String, String>> favoritos = [
  {'nome': 'Pau Brasil', 'imagePath': 'assets/images/pau_brasil.png'},
  {'nome': 'Cajueiro', 'imagePath': 'assets/images/cajueiro.png'},
  {'nome': 'Andiroba', 'imagePath': 'assets/images/andiroba.png'},
  {'nome': 'Jequitibá', 'imagePath': 'assets/images/jequitiba.png'},
  {'nome': 'Ipê Amarelo', 'imagePath': 'assets/images/ipe_amarelo.png'},
  {'nome': 'Mogno', 'imagePath': 'assets/images/mogno.png'},
];
