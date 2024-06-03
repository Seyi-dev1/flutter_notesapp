import 'package:flutter/material.dart';
import 'package:flutter_notes_app/models/notes_database.dart';
import 'package:flutter_notes_app/pages/notes_page.dart';
import 'package:flutter_notes_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  // initialize note isar database
  WidgetsFlutterBinding.ensureInitialized();
  await NotesDatabase.initialize();
  runApp(MultiProvider(
    providers: [
      //notes provider
      ChangeNotifierProvider(create: (context) => NotesDatabase()),

      //theme provider
      ChangeNotifierProvider(create: (context) => ThemeProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const NotesPage(),
    );
  }
}
