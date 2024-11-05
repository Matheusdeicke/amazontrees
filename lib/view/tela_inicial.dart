import 'package:flutter/material.dart';
import 'package:amazontrees/utils/colors.dart';
import 'tela_home.dart'; // Importe a TelaHome
import 'tela_lista_especies.dart'; // Importe a TelaListaEspecies
import 'tela_favoritos.dart'; // Importe a TelaFavoritos
import 'tela_sincronizar.dart'; // Importe a TelaSincronizar

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  int _selectedIndex = 0;

  // Lista de telas correspondentes a cada item da BottomNavigationBar
  final List<Widget> _telas = [
    TelaHome(),
    TelaListaEspecies(),
    // Adicione aqui as outras telas conforme necessário
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(0);
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Lista de Espécies'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(1);
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favoritos'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(2);
              },
            ),
            ListTile(
              leading: Icon(Icons.sync),
              title: Text('Sincronizar'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(3);
              },
            ),
          ],
        ),
      ),
      body: _telas[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.selectedNavigationBar, // Cor do item selecionado
        unselectedItemColor: AppColors.backgroundColor, // Cor dos itens não selecionados
        backgroundColor: AppColors.secondaryColor, // Cor de fundo da BottomNavigationBar
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista de Espécies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync),
            label: 'Sincronizar',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
