import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Etudiant.dart';
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
  Etudiant student = new Etudiant(nom: "", prenom: "", complete: false);

  Future<void> _obtenir() async {
    final DocumentSnapshot doc = await FirebaseFirestore.instance.collection('etudiants').doc('2128368').get();

    this.student = Etudiant.fromJson(doc.data() as Map<String, dynamic>, doc.id);
  }
  Future<void> _update() async{
    await FirebaseFirestore.instance.collection('etudiants').doc('2128368').update({'complete': !student.complete});
    _obtenir();

    setState(() {
    });
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
            ElevatedButton(
                child: Text("Obtenir"),
                onPressed: () async {
                  await _obtenir;
                  setState(() {

                  });
                }
            ),
            Text(student.nom ?? "pas trouvé"),
            Text(student.prenom ?? "pas trouvé"),
            ElevatedButton(
                child: Text("Mettre à jour"),
                onPressed: () async {
                  await _update();
                  setState(() {

                  });
                }
            ),
            Text(student.complete.toString() ?? "false"),
          ],
        ),
      ),
    );
  }
}
