import 'package:flutter/material.dart';
import 'package:tech_says_no/widgets/login.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _email = '';
  String _password = '';
  String _phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:const  EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Full name',
                        hintText: 'Enter your full name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _fullName = value!;
                      },
                    ),
                     const SizedBox(height: 20),
            
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                     const SizedBox(height: 20),
            
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                    ),
                     const SizedBox(height: 20),
            
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Phone number',
                        hintText: 'Enter your phone number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _phoneNumber = value!;
                      },
                    ),
                     const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // Perform login action with _email and _password
                          }
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 15)),
                          elevation: MaterialStateProperty.all(5),
                        ),
                        child: const Text('Register', style: TextStyle(fontSize: 18),),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                      child: const Text('Already have an account? Login here'),
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}