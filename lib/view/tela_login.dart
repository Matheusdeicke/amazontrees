import 'package:flutter/material.dart';
import 'package:amazontrees/utils/colors.dart';
import 'tela_inicial.dart';

class TelaLogin extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Espaçamento para descer a imagem
              SizedBox(height: 50),

              // Imagem fixa
              Container(
                width: 380,
                height: 400,
                child: Image.asset(
                  'assets/images/tree_logo.png',
                  fit: BoxFit.cover,
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Campo de Nome de Usuário
                          TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: 'Nome de Usuário',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon:
                                  Icon(Icons.person, color: Colors.white),
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 12),

                          // Campo de Senha
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.secondaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: Icon(Icons.lock, color: Colors.white),
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 12),

                          // Botão de Login
                          SizedBox(
                            width: 200, // Definindo a largura
                            height: 50, // Definindo a altura
                            child: ElevatedButton(
                              onPressed: () {
                                // Navegar para a TelaInicial
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TelaInicial()),
                                );
                              },
                              child: Text('Login'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryColor,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 35),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
