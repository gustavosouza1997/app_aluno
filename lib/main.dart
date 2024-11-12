import 'package:app_aluno/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'view/aluno_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Alunos',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF405DE6),
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF405DE6),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: AlunoPage(),
    );
  }
}