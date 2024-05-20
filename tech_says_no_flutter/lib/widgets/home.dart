import 'package:flutter/material.dart';

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
            padding: EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // App titlegit
                Text(
                  'SafeHand',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Montserrat', // Use a custom font
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 200),
                // Description
                Text(
                  'Press the button in times of need. Your safety is our priority.',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontFamily: 'Montserrat', // Use a custom font
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to send SOS page
                  },
                  child: Text(
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
}
