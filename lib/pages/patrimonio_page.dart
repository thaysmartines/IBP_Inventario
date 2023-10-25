import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invetario_flutter/Patrimonio.dart';
import 'package:invetario_flutter/pages/cadastro_page.dart';

import 'cadastrar_page.dart';

class PatrimonioPage extends StatelessWidget {
  Patrimonio patrimonio;

  PatrimonioPage({super.key, required this.patrimonio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            patrimonio.descricao,
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NovoPatrimonioPage(patrimonio: patrimonio,),
                  ),
                );
              },
              child: const Text('Editar'),
            ),
          ],
        ),
        body: ListView(
          children: [
            Image.network(patrimonio.img ??
                'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/1024px-Default_pfp.svg.png'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    patrimonio.valor,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
