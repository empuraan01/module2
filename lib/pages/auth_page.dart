import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:module2/pages/calculator_screen.dart';
//import 'package:module2/pages/login_screen.dart';
import 'package:module2/pages/loginorregister.dart';

class auth extends StatelessWidget {
  const auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const CalculatorApp();
              } else {
                return const lorp();
              }
            }));
  }
}
