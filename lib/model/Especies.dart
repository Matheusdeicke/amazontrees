class Arvore {
  final String nomePopular;
  final String descricaoBotanica;
  final BiologiaReprodutiva biologiaReprodutiva;
  final OcorrenciaNatural ocorrenciaNatural;
  final AspectosEcologicos aspectosEcologicos;
  final String? regeneracaoNatural;
  final Aproveitamento aproveitamento;
  final String? paisagismo;
  final Cultivo cultivo;
  final String? imagePath;

  Arvore({
    required this.nomePopular,
    required this.descricaoBotanica,
    required this.biologiaReprodutiva,
    required this.ocorrenciaNatural,
    required this.aspectosEcologicos,
    this.regeneracaoNatural,
    required this.aproveitamento,
    this.paisagismo,
    required this.cultivo,
    this.imagePath,
  });

  factory Arvore.fromJson(Map<String, dynamic> json) {
    print(json); // Para verificar a estrutura recebida
    return Arvore(
      nomePopular: json['nome_popular'] ?? 'Desconhecido',
      descricaoBotanica: json['descricao_botanica'] ?? '',
      biologiaReprodutiva: BiologiaReprodutiva.fromJson(json['biologia_reprodutiva']),
      ocorrenciaNatural: OcorrenciaNatural.fromJson(json['ocorrencia_natural']),
      aspectosEcologicos: AspectosEcologicos.fromJson(json['aspectos_ecologicos']),
      regeneracaoNatural: json['regeneracao_natural'],
      aproveitamento: Aproveitamento.fromJson(json['aproveitamento']),
      paisagismo: json['paisagismo'],
      cultivo: Cultivo.fromJson(json['cultivo']),
      imagePath: json['imagePath'], // Opcional
    );
  }
}

class BiologiaReprodutiva {
  final String sistemaSexual;
  final String vetorPolinizacao;
  final Map<String, String> floracao;
  final Map<String, String> frutificacao;
  final Dispersao dispersao;

  BiologiaReprodutiva({
    required this.sistemaSexual,
    required this.vetorPolinizacao,
    required this.floracao,
    required this.frutificacao,
    required this.dispersao,
  });

  factory BiologiaReprodutiva.fromJson(Map<String, dynamic> json) {
    return BiologiaReprodutiva(
      sistemaSexual: json['sistema_sexual'],
      vetorPolinizacao: json['vetor_polinizacao'],
      floracao: Map<String, String>.from(json['floracao']),
      frutificacao: Map<String, String>.from(json['frutificacao']),
      dispersao: Dispersao.fromJson(json['dispersao']),
    );
  }
}

class Dispersao {
  final List<String> tipos;
  final List<String> animais;

  Dispersao({
    required this.tipos,
    required this.animais,
  });

  factory Dispersao.fromJson(Map<String, dynamic> json) {
    return Dispersao(
      tipos: List<String>.from(json['tipos']),
      animais: List<String>.from(json['animais']),
    );
  }
}

class OcorrenciaNatural {
  final Map<String, String> latitude;
  final Map<String, String> altitude;
  final String mapa;

  OcorrenciaNatural({
    required this.latitude,
    required this.altitude,
    required this.mapa,
  });

  factory OcorrenciaNatural.fromJson(Map<String, dynamic> json) {
    return OcorrenciaNatural(
      latitude: Map<String, String>.from(json['latitude']),
      altitude: Map<String, String>.from(json['altitude']),
      mapa: json['mapa'],
    );
  }
}

class AspectosEcologicos {
  final String grupoSucessional;
  final Map<String, String> pragas;

  AspectosEcologicos({
    required this.grupoSucessional,
    required this.pragas,
  });

  factory AspectosEcologicos.fromJson(Map<String, dynamic> json) {
    return AspectosEcologicos(
      grupoSucessional: json['grupo_sucessional'],
      pragas: Map<String, String>.from(json['pragas']),
    );
  }
}

class Aproveitamento {
  final Alimentacao alimentacao;
  final Biotecnologico biotecnologico;
  final String bioatividade;

  Aproveitamento({
    required this.alimentacao,
    required this.biotecnologico,
    required this.bioatividade,
  });

  factory Aproveitamento.fromJson(Map<String, dynamic> json) {
    return Aproveitamento(
      alimentacao: Alimentacao.fromJson(json['alimentacao']),
      biotecnologico: Biotecnologico.fromJson(json['biotecnologico']),
      bioatividade: json['bioatividade'],
    );
  }
}

class Alimentacao {
  final Map<String, String> dadosNutricionais;
  final Map<String, String> formasConsumo;

  Alimentacao({
    required this.dadosNutricionais,
    required this.formasConsumo,
  });

  factory Alimentacao.fromJson(Map<String, dynamic> json) {
    return Alimentacao(
      dadosNutricionais: Map<String, String>.from(json['dados_nutricionais']),
      formasConsumo: Map<String, String>.from(json['formas_consumo']),
    );
  }
}

class Biotecnologico {
  final Map<String, bool> composicao;
  final String potenciaisBioprodutos;

  Biotecnologico({
    required this.composicao,
    required this.potenciaisBioprodutos,
  });

  factory Biotecnologico.fromJson(Map<String, dynamic> json) {
    return Biotecnologico(
      composicao: Map<String, bool>.from(json['composicao']),
      potenciaisBioprodutos: json['potenciais_bioprodutos'],
    );
  }
}

class Cultivo {
  final String colheitaBeneficiamento;
  final ProducaoMudas producaoMudas;
  final String transplante;
  final CuidadosEspeciais cuidadosEspeciais;

  Cultivo({
    required this.colheitaBeneficiamento,
    required this.producaoMudas,
    required this.transplante,
    required this.cuidadosEspeciais,
  });

  factory Cultivo.fromJson(Map<String, dynamic> json) {
    return Cultivo(
      colheitaBeneficiamento: json['colheita_beneficiamento'],
      producaoMudas: ProducaoMudas.fromJson(json['producao_mudas']),
      transplante: json['transplante'],
      cuidadosEspeciais: CuidadosEspeciais.fromJson(json['cuidados_especiais']),
    );
  }
}

class ProducaoMudas {
  final String semeadura;
  final String germinacao;

  ProducaoMudas({
    required this.semeadura,
    required this.germinacao,
  });

  factory ProducaoMudas.fromJson(Map<String, dynamic> json) {
    return ProducaoMudas(
      semeadura: json['semeadura'],
      germinacao: json['germinacao'],
    );
  }
}

class CuidadosEspeciais {
  final String agua;
  final Solos solos;

  CuidadosEspeciais({
    required this.agua,
    required this.solos,
  });

  factory CuidadosEspeciais.fromJson(Map<String, dynamic> json) {
    return CuidadosEspeciais(
      agua: json['agua'],
      solos: Solos.fromJson(json['solos']),
    );
  }
}

class Solos {
  final String tipo;
  final String ph;

  Solos({
    required this.tipo,
    required this.ph,
  });

  factory Solos.fromJson(Map<String, dynamic> json) {
    return Solos(
      tipo: json['tipo'],
      ph: json['pH'],
    );
  }
}
