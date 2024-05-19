import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthExample extends StatefulWidget {
  const PhoneAuthExample({super.key});

  @override
  State<PhoneAuthExample> createState() => _PhoneAuthExampleState();
}

class _PhoneAuthExampleState extends State<PhoneAuthExample> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _phoneNumberController = TextEditingController();
  String _verificationId = '';

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: _phoneNumberController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        // Fetch the user's phone number
        User? user = _auth.currentUser;
        print('User phone number: ${user?.phoneNumber}');
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
        });
        print('Code sent to ${_phoneNumberController.text}');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
  }

  void _signInWithSmsCode(String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: smsCode,
    );

    await _auth.signInWithCredential(credential);
    User? user = _auth.currentUser;
    print('User phone number: ${user?.phoneNumber}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyPhoneNumber,
              child: Text('Verify Phone Number'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: PhoneAuthExample()));
