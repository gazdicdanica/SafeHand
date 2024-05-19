import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_says_no/api/firebase_api.dart';
import 'package:tech_says_no/shared_prefs.dart';
import 'package:tech_says_no/widgets/add_contact.dart';
// import 'package:tech_says_no/widgets/add_contact.dart';
import 'package:tech_says_no/widgets/login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.instance.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().init();
  runApp(const ProviderScope(child:  MyApp()));
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
      home: FutureBuilder<String?>(
        future: SharedPreferencesService.instance.getString('email'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show splash screen while waiting for future
            return const Center(child: CircularProgressIndicator(),);
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('An error occurred: ${snapshot.error}'),
              ),
            );
          } else {
            // Show AddContact or LoginScreen based on shared preference
            final email = snapshot.data;
            return email != null ? const AddContact() : const LoginScreen();
          }
        },
    ),);
  }
}

