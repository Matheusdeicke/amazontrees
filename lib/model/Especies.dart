class Arvore {
  final String nomePopular;
  final String descricaoBotanica;
  final Map<String, dynamic> taxonomia;
  final Map<String, dynamic> biologiaReprodutiva;
  final Map<String, dynamic> ocorrenciaNatural;
  final Map<String, dynamic> aspectosEcologicos;
  final String regeneracaoNatural;
  final Map<String, dynamic> aproveitamento;
  final String paisagismo;
  final Map<String, dynamic> cultivo;
  final Map<String, dynamic> composicaoNutricional;
  final List<String> pragas;
  final Map<String, dynamic> solos;
  final String imagemUrl;

  Arvore({
    required this.nomePopular,
    required this.descricaoBotanica,
    required this.taxonomia,
    required this.biologiaReprodutiva,
    required this.ocorrenciaNatural,
    required this.aspectosEcologicos,
    required this.regeneracaoNatural,
    required this.aproveitamento,
    required this.paisagismo,
    required this.cultivo,
    required this.composicaoNutricional,
    required this.pragas,
    required this.solos,
    required this.imagemUrl,
  });

  // Método para criar uma instância a partir do JSON
  factory Arvore.fromJson(Map<String, dynamic> json) {
    return Arvore(
      nomePopular: json['nome_popular'] ?? 'Desconhecido',
      descricaoBotanica: json['descricao_botanica'] ?? 'Descrição não disponível',
      taxonomia: json['taxonomia'] is Map<String, dynamic> ? json['taxonomia'] : {},
      biologiaReprodutiva: json['biologia_reprodutiva'] is Map<String, dynamic> ? json['biologia_reprodutiva'] : {},
      ocorrenciaNatural: json['ocorrencia_natural'] is Map<String, dynamic> ? json['ocorrencia_natural'] : {},
      aspectosEcologicos: json['aspectos_ecologicos'] is Map<String, dynamic> ? json['aspectos_ecologicos'] : {},
      regeneracaoNatural: json['regeneracao_natural'] ?? 'Não disponível',
      aproveitamento: json['aproveitamento'] is Map<String, dynamic> ? json['aproveitamento'] : {},
      paisagismo: json['paisagismo'] ?? 'Não disponível',
      cultivo: json['cultivo'] is Map<String, dynamic> ? json['cultivo'] : {},
      composicaoNutricional: json['composicao_nutricional'] is Map<String, dynamic> ? json['composicao_nutricional'] : {},
      pragas: json['pragas'] is List<dynamic> ? List<String>.from(json['pragas']) : [],
      solos: json['solos'] is Map<String, dynamic> ? json['solos'] : {},
      imagemUrl: json['imagem_url'] ?? '',
    );
  }

  // Método para converter uma instância para JSON
  Map<String, dynamic> toJson() {
    return {
      'nome_popular': nomePopular,
      'descricao_botanica': descricaoBotanica,
      'taxonomia': taxonomia,
      'biologia_reprodutiva': biologiaReprodutiva,
      'ocorrencia_natural': ocorrenciaNatural,
      'aspectos_ecologicos': aspectosEcologicos,
      'regeneracao_natural': regeneracaoNatural,
      'aproveitamento': aproveitamento,
      'paisagismo': paisagismo,
      'cultivo': cultivo,
      'composicao_nutricional': composicaoNutricional,
      'pragas': pragas,
      'solos': solos,
      'imagem_url': imagemUrl,
    };
  }
}
