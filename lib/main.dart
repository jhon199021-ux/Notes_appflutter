import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/database_factory.dart';
import 'providers/note_provider.dart';
import 'screens/login_screen.dart';

void main() async {
  configureDatabaseFactory();

  runApp(
    ChangeNotifierProvider(
      create: (_) => NoteProvider()..loadNotes(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Note App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LoginScreen(),
    );
  }
}