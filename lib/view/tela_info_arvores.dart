import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../model/Especies.dart';

class TelaInfoArvores extends StatelessWidget {
  final Arvore arvore; // Agora recebemos o objeto completo.

  TelaInfoArvores({required this.arvore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                // Imagem da árvore
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
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: arvore.imagemUrl.isNotEmpty
                            ? Image.network(
                          arvore.imagemUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/error_image.png',
                              fit: BoxFit.cover,
                            );
                          },
                        )
                            : Image.asset(
                          'assets/images/error_image.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                // Informações em uma única caixa branca
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Alinha à esquerda (exceto Nome Popular)
                    children: [
                      // Nome Popular (centralizado)
                      Center(
                        child: Text(
                          arvore.nomePopular,
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Informações Detalhadas
                      _buildDetailsSection(
                        'Descrição Botânica',
                        arvore.descricaoBotanica,
                      ),
                      _buildDetailsSection(
                        'Taxonomia',
                        arvore.taxonomia.toString(),
                      ),
                      _buildDetailsSection(
                        'Biologia Reprodutiva',
                        '''
Sistema Sexual: ${arvore.biologiaReprodutiva['sistema_sexual'] ?? 'Não disponível'}
Vetor de Polinização: ${arvore.biologiaReprodutiva['vetor_polinizacao'] ?? 'Não disponível'}
Floração: ${arvore.biologiaReprodutiva['floracao'] ?? 'Não disponível'}
Frutificação: ${arvore.biologiaReprodutiva['frutificacao'] ?? 'Não disponível'}
                        ''',
                      ),
                      _buildDetailsSection(
                        'Ocorrência Natural',
                        '''
Latitude: ${arvore.ocorrenciaNatural['latitude'] ?? 'Não disponível'}
Altitude: ${arvore.ocorrenciaNatural['altitude'] ?? 'Não disponível'}
Mapa: ${arvore.ocorrenciaNatural['mapa'] ?? 'Não disponível'}
                        ''',
                      ),
                      _buildDetailsSection(
                        'Aspectos Ecológicos',
                        arvore.aspectosEcologicos.toString(),
                      ),
                      _buildDetailsSection(
                        'Regeneração Natural',
                        arvore.regeneracaoNatural,
                      ),
                      _buildDetailsSection(
                        'Aproveitamento',
                        arvore.aproveitamento.toString(),
                      ),
                      _buildDetailsSection(
                        'Paisagismo',
                        arvore.paisagismo,
                      ),
                      _buildDetailsSection(
                        'Cultivo',
                        arvore.cultivo.toString(),
                      ),
                      _buildDetailsSection(
                        'Composição Nutricional',
                        arvore.composicaoNutricional.toString(),
                      ),
                      _buildDetailsSection(
                        'Pragas',
                        arvore.pragas.isNotEmpty
                            ? arvore.pragas.join(', ')
                            : 'Não disponível',
                      ),
                      _buildDetailsSection(
                        'Solos',
                        arvore.solos.toString(),
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

  Widget _buildDetailsSection(String title, dynamic content) {
    String formattedContent;
    if (content is List && content.isNotEmpty) {
      // Formata listas, uma entrada por linha
      formattedContent = content.map((e) => '• $e').join('\n');
    } else {
      // Exibe conteúdo como texto simples
      formattedContent = content.toString().trim().isNotEmpty
          ? content.toString().trim()
          : 'Não disponível';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alinha à esquerda
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
            formattedContent,
            style: TextStyle(fontSize: 14, color: Colors.black87),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
