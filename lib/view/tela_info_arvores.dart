import 'package:flutter/material.dart';
import '../utils/colors.dart';

class TelaInfoArvores extends StatelessWidget {
  final String nome;
  final String descricao;
  final String imagePath;

  TelaInfoArvores({required this.nome, required this.descricao, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Detalhes da árvore'),
        centerTitle: true,
        backgroundColor: AppColors.secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Imagem da árvore
            Container(
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(12.0), // Ajuste o valor para o arredondamento desejado
              ),
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.all(20.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            // Nome da árvore
            Text(
              nome,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            // Descrição
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                descricao,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
