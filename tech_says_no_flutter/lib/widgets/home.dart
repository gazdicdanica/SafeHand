import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stay Safe in Style'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Slide 1
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    Image.asset('assets/sos_pendant.jpg', width: 200.0),
                    const SizedBox(height: 16.0),
                    const Text(
                      'SOS Jewelry',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            // Slide 2
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How it Works',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                      'Effortless Setup: Download the app and pair it with your SOS pendant.'),
                  SizedBox(height: 4.0),
                  Text(
                      'Add Emergency Contacts: Select trusted individuals who will receive your emergency alerts.'),
                  SizedBox(height: 4.0),
                  Text(
                      'Discreet Activation: A simple press on the SOS button discreetly sends an alert.'),
                ],
              ),
            ),

            // Slide 3
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/sos_alert.jpg', width: 150.0),
                  const SizedBox(width: 16.0),
                  const Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Features for Peace of Mind',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Text('Real-Time Location Sharing'),
                        SizedBox(height: 4.0),
                        Text('Discreet Activation'),
                        SizedBox(height: 4.0),
                        Text('Customizable App'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Slide 4
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      'Style Meets Security',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Wrap(
                      spacing: 16.0,
                      runSpacing: 16.0,
                      children: [
                        Image.asset('assets/pendant_silver.jpg', width: 100.0),
                        Image.asset('assets/pendant_rose_gold.jpg',
                            width: 100.0),
                        Image.asset('assets/pendant_black.jpg', width: 100.0),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Slide 5
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Download the App and Take Control of Your Safety',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
