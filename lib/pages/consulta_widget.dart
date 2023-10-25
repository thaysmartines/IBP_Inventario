import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Consulta extends StatefulWidget {
  const Consulta({super.key});

  @override
  State<Consulta> createState() => _ConsultaState();
}

class _ConsultaState extends State<Consulta> {
  final Stream<QuerySnapshot> patrimonios =
      FirebaseFirestore.instance.collection('patrimonio').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.brown[200],
      ),
      body: StreamBuilder(
        stream: patrimonios,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Erro ao buscar os patrimonios');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return ListView(
            children:
                snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
              Map<String, dynamic> patrimonio =
                  documentSnapshot.data()! as Map<String, dynamic>;
              return ListTile(
                
                leading: Image.network(
                    'https://img.favpng.com/23/20/7/computer-icons-information-png-favpng-g8DtjAPPNhyaU9EdjHQJRnV97_t.jpg'),
               
                title: Text(patrimonio['descricao']),
                subtitle: Text(patrimonio['dataaquisicao']),
                trailing: Text(patrimonio['valorbem']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
