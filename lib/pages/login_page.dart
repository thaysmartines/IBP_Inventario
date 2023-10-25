// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:invetario_flutter/pages/cadastro_user.dart';
import 'package:invetario_flutter/pages/esqueci_senha.dart';
import 'package:invetario_flutter/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  bool carregando = false;

  final formKey = GlobalKey<
      FormState>(); //formeKey vai carregar a validação dos TextFormFild para Button

  bool saved = false; //variável saved

  StreamSubscription? streamSubscription;

  @override
  void initState() {
    streamSubscription = _firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => Homepage(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: carregando
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Form(
                key: formKey,
                child: ListView(
                  padding: EdgeInsets.all(10),
                  children: [
                    Image.asset('assets/images/logo.png',
                        height: 300, width: 300),
                    // Text('Usuário: ${_firebaseAuth.currentUser!.email??''}'),
                    TextFormField(
                      controller: _emailController,
                      autofocus: true, //quando,)
                      //acessar essa tela, vai focar nesta campo
                      keyboardType: TextInputType
                          .text, // carrega o teclado para somente númerico se for o caso
                      style: Theme.of(context).textTheme.displayMedium,
                      decoration: InputDecoration(
                        labelText: "USUÁRIO",
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          //valida se é vazio ou null
                          return 'Usuário Obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      autofocus: true,
                      obscureText:
                          true, //quando acessar essa tela, vai focar nesta campo
                      keyboardType: TextInputType
                          .text, // carrega o teclado para somente númerico se for o caso
                      style: Theme.of(context).textTheme.displayMedium,
                      decoration: InputDecoration(
                        labelText: "SENHA",
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Senha Obrigatória';
                        }
                        return null;
                      },
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Esqueci senha'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerRight,
                        textStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() == true) {
                          login();
                        }
                      },
                      child: Text(
                        "ENTRAR",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CadastroUser(),
                          ),
                        );
                      },
                      child: const Text(
                        'Não tem conta? Cadastre-se',
                        style: TextStyle(color: Colors.brown),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  login() async {
    setState(() {
      carregando = true;
    });
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // ignore: unnecessary_null_comparison
      if (userCredential != null) {
        setState(() {
          carregando = false;
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        carregando = false;
      });
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário não encontrado'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sua senha está incorreta'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }
}
