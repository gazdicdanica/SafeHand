import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tech_says_no/api/firebase_api.dart';
import 'package:tech_says_no/widgets/login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafetyBuddy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 159, 245)),
        useMaterial3: true,
      ),
      home: const LoginScreen()
    );
  }
}

