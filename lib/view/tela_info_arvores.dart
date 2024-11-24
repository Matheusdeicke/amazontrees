import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../model/Especies.dart';

class TelaInfoArvores extends StatelessWidget {
  final Arvore arvore;

  TelaInfoArvores({required this.arvore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Detalhes da árvore'),
        centerTitle: true,
        backgroundColor: AppColors.secondaryColor,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 600, // Limita a largura máxima para telas maiores
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                // Caixa para a imagem
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: SizedBox(
                      width: 200,
                      height: 200, // Define altura e largura iguais para formato quadrado
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          arvore.image_url ?? 'assets/images/error_image.png',
                          fit: BoxFit.cover, // Ajusta a imagem ao espaço sem distorcer
                        ),
                      ),
                    ),
                  ),
                ),

                // Nome popular
                Text(
                  arvore.nomePopular,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Caixa para o texto completo
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Descrição Botânica
                      _buildSection('Descrição Botânica', arvore.descricaoBotanica),

                      // Biologia Reprodutiva
                      _buildSection(
                        'Biologia Reprodutiva',
                        '''
Sistema Sexual: ${arvore.biologiaReprodutiva.sistemaSexual}
Vetor de Polinização: ${arvore.biologiaReprodutiva.vetorPolinizacao}
Floração: ${arvore.biologiaReprodutiva.floracao.toString()}
Frutificação: ${arvore.biologiaReprodutiva.frutificacao.toString()}
                        ''',
                      ),

                      // Ocorrência Natural
                      _buildSection(
                        'Ocorrência Natural',
                        '''
Latitude: ${arvore.ocorrenciaNatural.latitude.toString()}
Altitude: ${arvore.ocorrenciaNatural.altitude.toString()}
Mapa: ${arvore.ocorrenciaNatural.mapa}
                        ''',
                      ),

                      // Aspectos Ecológicos
                      _buildSection(
                        'Aspectos Ecológicos',
                        '''
Grupo Sucessional: ${arvore.aspectosEcologicos.grupoSucessional}
Pragas: ${arvore.aspectosEcologicos.pragas.toString()}
                        ''',
                      ),

                      // Aproveitamento
                      _buildSection(
                        'Aproveitamento',
                        '''
Alimentação: ${arvore.aproveitamento.alimentacao.dadosNutricionais.toString()}
Biotecnológico: ${arvore.aproveitamento.biotecnologico.composicao.toString()}
Bioatividade: ${arvore.aproveitamento.bioatividade}
                        ''',
                      ),

                      // Cultivo
                      _buildSection(
                        'Cultivo',
                        '''
Colheita e Beneficiamento: ${arvore.cultivo.colheitaBeneficiamento}
Produção de Mudas: ${arvore.cultivo.producaoMudas.toString()}
Transplante: ${arvore.cultivo.transplante}
Cuidados Especiais: ${arvore.cultivo.cuidadosEspeciais.toString()}
                        ''',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(fontSize: 14, color: Colors.black87),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
