import 'package:flutter/material.dart';
import 'package:amazontrees/utils/colors.dart';
import 'tela_inicial.dart';
import 'dart:async';

class TelaCarregamento extends StatefulWidget {
  @override
  _TelaCarregamentoState createState() => _TelaCarregamentoState();
}

class _TelaCarregamentoState extends State<TelaCarregamento> {
  @override
  void initState() {
    super.initState();
    // Simulação de carregamento
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TelaInicial()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 200,
              height: 200,
              child: Image.asset(
                'assets/images/tree_logo.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            // Texto de Carregamento
            Text(
              'Carregando...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Indicador de Progresso
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
