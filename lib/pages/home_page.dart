import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:invetario_flutter/Patrimonio.dart';
import 'package:invetario_flutter/checagem_page.dart';
import 'package:invetario_flutter/pages/cadastro_page.dart';
import 'package:invetario_flutter/pages/login_page.dart';
import 'package:invetario_flutter/pages/patrimonio_page.dart';

import 'cadastrar_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool saved = false;

  final _firebaseAuth = FirebaseAuth.instance;

  StreamSubscription? streamSubscription;

  @override
  void initState() {
    streamSubscription = _firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const ChecagemPage(),
          ),
          (context) => false,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription?.cancel();

    super.dispose();
  }

  final Stream<QuerySnapshot> patrimonios =
      FirebaseFirestore.instance.collection('patrimonios').snapshots();

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signOut();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => NovoPatrimonioPage()));
        },
        child: Icon(Icons.add_task),
      ),
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          height: 30,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      drawer: const Drawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: patrimonios,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Erro ao buscar dados');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Patrimonio patrimonio = Patrimonio.fromJson(
                    snapshot.data!.docs[index].data() as Map<String, dynamic>);
                return ListTile(
                  tileColor: Colors.white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PatrimonioPage(patrimonio: patrimonio),
                      ),
                    );
                  },
                  onLongPress: () {
                    _dialogBuilder(
                        context: context, id: snapshot.data!.docs[index].id);
                  },
                  leading: Image.network(
                    patrimonio.img ??
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/1024px-Default_pfp.svg.png',
                    fit: BoxFit.cover,
                  ),
                  title: Text(patrimonio.descricao),
                  subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(patrimonio.cod),
                        Text('R\$ ${patrimonio.valor}'),
                      ]),
                );
              });
        },
      ),
    );
  }

  Future<void> _dialogBuilder(
      {required BuildContext context, required String id}) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir Patrimonio'),
          content: const Text(
            'Ao fazer isso, não será mais possível restaurar o Patrimonio!',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Apagar'),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('patrimonios')
                    .doc(id)
                    .delete()
                    .then((value) {
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }
}
