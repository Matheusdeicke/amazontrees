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
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                // Botão de voltar
                Align(
                  alignment: Alignment.centerLeft, // Alinha à esquerda
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
                    onPressed: () => Navigator.pop(context), // Ação de voltar
                  ),
                ),
                const SizedBox(height: 8), // Espaço entre o botão e a imagem

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

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      _buildDetailsSection(
                        'Descrição Botânica',
                        arvore.descricaoBotanica,
                      ),
                      _buildDetailsSection(
                        'Taxonomia',
                        arvore.taxonomia,
                      ),
                      _buildDetailsSection(
                        'Biologia Reprodutiva',
                        {
                          'Sistema Sexual': arvore.biologiaReprodutiva['sistema_sexual'] ?? 'Não disponível',
                          'Vetor de Polinização': arvore.biologiaReprodutiva['vetor_polinizacao'] ?? 'Não disponível',
                          'Floração': arvore.biologiaReprodutiva['floracao'] ?? 'Não disponível',
                          'Frutificação': arvore.biologiaReprodutiva['frutificacao'] ?? 'Não disponível',
                          'Dispersão': arvore.biologiaReprodutiva['dispersao'] ?? 'Não disponível',
                        },
                      ),
                      _buildDetailsSection(
                        'Ocorrência Natural',
                        {
                          'Latitude': arvore.ocorrenciaNatural['latitude'] ?? 'Não disponível',
                          'Altitude': arvore.ocorrenciaNatural['altitude'] ?? 'Não disponível',
                          'Mapa': arvore.ocorrenciaNatural['mapa'] ?? 'Não disponível',
                        },
                      ),
                      _buildDetailsSection(
                        'Aspectos Ecológicos',
                        arvore.aspectosEcologicos,
                      ),
                      _buildDetailsSection(
                        'Regeneração Natural',
                        arvore.regeneracaoNatural,
                      ),
                      _buildDetailsSection(
                        'Aproveitamento',
                        arvore.aproveitamento,
                      ),
                      _buildDetailsSection(
                        'Paisagismo',
                        arvore.paisagismo,
                      ),
                      _buildDetailsSection(
                        'Cultivo',
                        arvore.cultivo,
                      ),
                      _buildDetailsSection(
                        'Composição Nutricional',
                        arvore.composicaoNutricional,
                      ),
                      _buildDetailsSection(
                        'Pragas',
                        arvore.pragas.isNotEmpty
                            ? arvore.pragas
                            : 'Não disponível',
                      ),
                      _buildDetailsSection(
                        'Solos',
                        arvore.solos,
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
    String formattedContent = _formatContent(content);

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

  String _formatContent(dynamic content) {
    if (content is Map && content.isNotEmpty) {
      return content.entries
          .map((entry) =>
      '${_capitalizeAndRemoveUnderscore(entry.key)}:\n${_formatContent(entry.value)}\n') // Aplica a formatação nas chaves
          .join('\n');
    } else if (content is List && content.isNotEmpty) {
      return content.map((e) => '• ${_formatContent(e)}').join('\n'); // Formata listas
    } else if (content is String) {
      return content.trim().isNotEmpty ? content.trim() : 'Não disponível'; // Formata strings
    } else {
      return 'Não disponível';
    }
  }

  String _capitalizeAndRemoveUnderscore(String text) {
    return text
        .replaceAll('_', ' ') // Remove underscores
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1)) // Capitaliza cada palavra
        .join(' '); // Recompõe a string com espaços
  }
}
