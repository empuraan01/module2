import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controltext;
  final String hintText;
  final bool obscureText;

   const MyTextField(
      {super.key,
      required this.controltext,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controltext,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 203, 202, 202))),
            fillColor: const Color.fromARGB(255, 199, 199, 199),
            filled: true,
            hintText: hintText),
      ),
    );
  }
}
