import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/Especies.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('arvore.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE arvore (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_popular TEXT NOT NULL,
        descricao_botanica TEXT,
        taxonomia TEXT,
        biologia_reprodutiva TEXT,
        ocorrencia_natural TEXT,
        aspectos_ecologicos TEXT,
        regeneracao_natural TEXT,
        aproveitamento TEXT,
        paisagismo TEXT,
        cultivo TEXT,
        composicao_nutricional TEXT,
        pragas TEXT,
        solos TEXT,
        imagem_url TEXT
      )
    ''');
  }

  Future<void> insertArvore(Arvore arvore) async {
    final db = await instance.database;
    await db.insert(
      'arvore',
      {
        'nome_popular': arvore.nomePopular,
        'descricao_botanica': arvore.descricaoBotanica,
        'taxonomia': jsonEncode(arvore.taxonomia),
        'biologia_reprodutiva': jsonEncode(arvore.biologiaReprodutiva),
        'ocorrencia_natural': jsonEncode(arvore.ocorrenciaNatural),
        'aspectos_ecologicos': jsonEncode(arvore.aspectosEcologicos),
        'regeneracao_natural': arvore.regeneracaoNatural,
        'aproveitamento': jsonEncode(arvore.aproveitamento),
        'paisagismo': arvore.paisagismo,
        'cultivo': jsonEncode(arvore.cultivo),
        'composicao_nutricional': jsonEncode(arvore.composicaoNutricional),
        'pragas': jsonEncode(arvore.pragas),
        'solos': jsonEncode(arvore.solos),
        'imagem_url': arvore.imagemUrl,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Arvore>> fetchArvores() async {
    final db = await instance.database;

    // Obtém todos os registros da tabela 'arvore'
    final List<Map<String, dynamic>> result = await db.query('arvore');

    // Converte os registros em uma lista de objetos `Arvore`
    return result.map((json) {
      return Arvore.fromJson({
        'nome_popular': json['nome_popular'],
        'descricao_botanica': json['descricao_botanica'],
        'taxonomia': jsonDecode(json['taxonomia']), // Decodifica JSON armazenado como string
        'biologia_reprodutiva': jsonDecode(json['biologia_reprodutiva']),
        'ocorrencia_natural': jsonDecode(json['ocorrencia_natural']),
        'aspectos_ecologicos': jsonDecode(json['aspectos_ecologicos']),
        'regeneracao_natural': json['regeneracao_natural'],
        'aproveitamento': jsonDecode(json['aproveitamento']),
        'paisagismo': json['paisagismo'],
        'cultivo': jsonDecode(json['cultivo']),
        'composicao_nutricional': jsonDecode(json['composicao_nutricional']),
        'pragas': List<String>.from(jsonDecode(json['pragas'])), // Decodifica e converte em lista de strings
        'solos': jsonDecode(json['solos']),
        'imagem_url': json['imagem_url'],
      });
    }).toList();
  }


  Future<void> clearArvore() async {
    final db = await instance.database;
    await db.delete('arvore');
  }

  Future<Arvore?> fetchArvoreById(int id) async {
    final db = await DatabaseHelper
        .instance.database; // Usa a instância correta do DatabaseHelper
    final result = await db.query(
      'arvore',
      where: 'id = ?', // Filtro pela coluna 'id'
      whereArgs: [id], // Argumento para o filtro
      limit: 1, // Limita o resultado a uma única linha
    );

    if (result.isNotEmpty) {
      final json = result.first;
      return Arvore.fromJson({
        'nome_popular': json['nome_popular'],
        'descricao_botanica': json['descricao_botanica'],
        'taxonomia': (json['taxonomia']), // Decodifica os campos JSON
        'biologia_reprodutiva': (json['biologia_reprodutiva']),
        'ocorrencia_natural': (json['ocorrencia_natural']),
        'aspectos_ecologicos': (json['aspectos_ecologicos']),
        'regeneracao_natural': json['regeneracao_natural'],
        'aproveitamento': (json['aproveitamento']),
        'paisagismo': json['paisagismo'],
        'cultivo': (json['cultivo']),
        'composicao_nutricional': (json['composicao_nutricional']),
        'pragas': List<String>.from(['pragas']),
        'solos': (json['solos']),
        'imagem_url': json['imagem_url'],
      });
    }
    return null;
  }
}
