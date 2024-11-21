import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tela_lista_especies.dart';  // Importando a tela correta
import '../utils/colors.dart';

class TelaHome extends StatelessWidget {
  // Função de sincronizar
  void sincronizarDados() {
    // Aqui você pode implementar a lógica de sincronização com o servidor
    print("Sincronizando dados...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

            // Botões
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildActionButton(
                    context,
                    icon: Icons.cloud_done,
                    label: 'Árvores Cadastradas',
                    onPressed: () {
                      // Abre a tela da lista de espécies
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TelaListaEspecies()),
                      );
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _buildActionButton(
                    context,
                    icon: Icons.sync,
                    label: 'Sincronizar',
                    onPressed: () {
                      sincronizarDados();  // Chama a função de sincronização
                    },
                  ),
                ),
              ],
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
