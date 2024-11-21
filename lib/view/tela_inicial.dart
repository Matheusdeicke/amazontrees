import 'package:flutter/material.dart';
import 'package:amazontrees/utils/colors.dart';
import 'tela_home.dart'; // Importe a TelaHome
import 'tela_lista_especies.dart'; // Importe a TelaListaEspecies

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  int _selectedIndex = 0;

  // Lista de telas correspondentes a cada item da NavigationBar
  final List<Widget> _telas = [
    TelaHome(),
    TelaListaEspecies(),
    // Adicione outras telas conforme necessário
    Center(child: Text("Sincronizar", style: TextStyle(fontSize: 24))),
    Center(child: Text("Sobre", style: TextStyle(fontSize: 24))),
  ];

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
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Lista de Espécies'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.sync),
              title: Text('Sincronizar'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Sobre'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
      body: _telas[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedIndex: _selectedIndex,
        indicatorColor: AppColors.primaryColor, // Cor do indicador selecionado
        backgroundColor: AppColors.secondaryColor, // Cor de fundo da NavigationBar
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.list),
            icon: Icon(Icons.list_outlined),
            label: 'Lista de Espécies',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.sync),
            icon: Icon(Icons.sync_outlined),
            label: 'Sincronizar',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.info),
            icon: Icon(Icons.info_outlined),
            label: 'Sobre',
          ),
        ],
      ),
    );
  }
}
