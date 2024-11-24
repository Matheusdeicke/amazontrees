import 'package:flutter/material.dart';
import '../utils/colors.dart';

class TelaSobre extends StatelessWidget {
  final List<Map<String, String>> integrantes = [
    {
      'nome': 'Matheus Silva',
      'descricao': 'Desenvolvedor Full Stack apaixonado por tecnologia e design de interfaces.',
      'imagem': 'assets/images/caio_kirst.png'
    },
    {
      'nome': 'Joana Santos',
      'descricao': 'Engenheira de Software focada em soluções escaláveis e inovadoras.',
      'imagem': 'assets/images/gustavo_motta.png'
    },
    {
      'nome': 'Carlos Oliveira',
      'descricao': 'Especialista em bancos de dados e segurança da informação.',
      'imagem': 'assets/images/matheus_deicke.png'
    },
    {
      'nome': 'Ana Souza',
      'descricao': 'UI/UX Designer com experiência em design centrado no usuário.',
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
