import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class lorp extends StatefulWidget {
  const lorp({super.key});

  @override
  State<lorp> createState() => _lorp();
}

class _lorp extends State<lorp> {
  bool ifloggedin = true;

  void togglebwscreens() {
    setState(() {
      ifloggedin = !ifloggedin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ifloggedin) {
      return LoginPage(onTap: togglebwscreens);
    } else {
      return SignUpPage(onTap: togglebwscreens);
    }
  }
}
