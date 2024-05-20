import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tech_says_no/shared_prefs.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background image
          Image.asset(
            'assets/background_image.jpg', // Provide your own image path
            fit: BoxFit.cover,
          ),
          // Overlay with gradient
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // App titlegit
                const Text(
                  'SafeHand',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Montserrat', // Use a custom font
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 200),
                // Description
                const Text(
                  'Press the button in times of need. Your safety is our priority.',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontFamily: 'Montserrat', // Use a custom font
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    alert();
                  },
                  child: const Text(
                    'Send SOS Alert',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Montserrat', // Use a custom font
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void alert() async {
    await http.post(
      Uri.parse('http://192.168.0.19:5000/alert'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email':
            await SharedPreferencesService.instance.getString('email') ?? '',
      }),
    );
  }
}
