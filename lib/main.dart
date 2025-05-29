import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/note_model.dart';
import 'screens/home_screen.dart';
import 'screens/add_edit_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase CRUD App',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Color(0xFFF5F6FA),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/add-edit': (context) {
          final Note? note =
              ModalRoute.of(context)?.settings.arguments as Note?;
          return AddEditScreen(note: note);
        },
      },
    );
  }
}
