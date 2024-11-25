import 'package:flutter/material.dart';
import '../utils/colors.dart';

class TelaSobre extends StatelessWidget {
  final List<Map<String, String>> integrantes = [
    {
      'nome': 'Caio Kirst',
      'descricao': '21 anos e atualmente estuda Ciências da Computação na UNISC.\nGithub: caiokirst.',
      'imagem': 'assets/images/caio_kirst.png'
    },
    {
      'nome': 'Gustavo Motta',
      'descricao': '21 anos e atualmente estuda Ciências da Computação na UNISC.\nGithub: gusstavomotta.',
      'imagem': 'assets/images/gustavo_motta.png'
    },
    {
      'nome': 'Matheus Deicke',
      'descricao': '21 anos e atualmente estuda Ciências da Computação na UNISC.\nGithub: matheusdeicke.',
      'imagem': 'assets/images/matheus_deicke.png'
    },
    {
      'nome': 'Victor Eduardo',
      'descricao': '25 anos e atualmente estuda Ciências da Computação na UNISC.\nGithub: nascimas.',
      'imagem': 'assets/images/victor_eduardo.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Limita a altura ao conteúdo
          children: integrantes.map((integrante) {
            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Imagem do integrante
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset(
                        integrante['imagem']!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    // Informações do integrante
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            integrante['nome']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            integrante['descricao']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
