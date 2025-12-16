import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String resultat = "";
  final Dio dio = Dio();
  final _dividende = TextEditingController(text: "100");
  final _diviseur = TextEditingController(text: "20");

  Future<void> _requete() async{
    try {
      final response = await dio.get("https://examen-final-a24.azurewebsites.net/Exam2024/Division/${_dividende.text}/${_diviseur.text}");
      setState(() {
        resultat = response.data['resultat'].toString();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Réponse : " +resultat)));

    } on DioException catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ça marche pas nom ami: "+ e.message.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(controller: _dividende,),
            TextField(controller: _diviseur,),
            ElevatedButton(
              onPressed: () async {
                await _requete();
              },
              child: Text("Calculer"),
            ),
            Text("Réponse : " +resultat),
          ],
        ),
      ),
    );
  }
}
//Qu'est-ce que le contrôle d'accès, et comment est-il mis en place dans le TP3 du cours d'applications mobiles avancées?
/*

Le contrôle d'accès dans le TP3 permet de garder les informations des utilisateurs sécuritaire
et de ne laisser que eux y accéder. Nous pouvons le mettre en place en allant sur firebase,
ensuite dans la base de données et finalement dans les règles de la base de données et faire en sorte
que le uid du l'utilisateur qui fait la requête corresponde au uid de la collection dans la base de données.

 */