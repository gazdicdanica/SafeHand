import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background image
          Image.asset(
            'assets/background_image.jpg', // Provide your own image path
            fit: BoxFit.cover,
          ),
          // Overlay with gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // App title
                Text(
                  'SOS Jewelry',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Montserrat', // Use a custom font
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                // Description
                Text(
                  'In case of an emergency, your emergency contacts will be notified with your location.',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontFamily: 'Montserrat', // Use a custom font
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                // Buttons
                ElevatedButton(
                  onPressed: () {
                    // Navigate to add contact page
                  },
                  child: Text(
                    'Add Emergency Contact',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Montserrat', // Use a custom font
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
