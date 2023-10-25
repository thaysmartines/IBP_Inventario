import 'package:flutter/material.dart';
import 'package:invetario_flutter/pages/pages.dart';
import 'checagem_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'invetario_flutter',
      theme: ThemeData(
          // fontFamily: 'COMIC',
          useMaterial3: true,
          scaffoldBackgroundColor: Color.fromARGB(255, 231, 219, 219),
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            displayMedium: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.black),
          )),
      debugShowCheckedModeBanner: false,
      home: const ChecagemPage(),
    );
  }
}
