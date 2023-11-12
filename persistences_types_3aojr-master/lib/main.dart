import 'package:flutter/material.dart';
import 'package:persistences_types_3aojr/firebase/screens/list.dart';
import 'package:persistences_types_3aojr/floor/screens/list.dart';
import 'package:persistences_types_3aojr/screens/principal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      routes: {
        "/" : (context) => PrincipalWidget(),
        "/books" : (context) => BooksListWidget(),
        "/cars" : (context) => CarsListWidget(),
      },
      initialRoute: "/",
    );
  }
}