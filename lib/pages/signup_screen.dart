import 'package:flutter/material.dart';
import 'package:module2/components/button.dart';
//import 'package:module2/components/imagebutton.dart';
import 'package:module2/components/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  final Function()? onTap;
  const SignUpPage({super.key, required this.onTap});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //sign in function
  void signUserUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        wrongauthmessage();
      } else if (e.code == 'wrong-password') {
        wrongauthmessage();
      }
    }
  }

  void wrongauthmessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Incorrect credentials'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                const ImageIcon(
                  AssetImage('lib/images/calculator_icon.jpeg'),
                  color: Colors.black,
                  size: 100,
                ),

                const SizedBox(
                  height: 50,
                ),

                // welcome
                const Text(
                  'Create an account',
                  style: TextStyle(
                    color: Color.fromARGB(255, 79, 78, 78),
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),
                //username textfield

                MyTextField(
                  controltext: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 25),

                //password textfield

                MyTextField(
                  controltext: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                //sign in button
                Button(
                  onTap: signUserUp,
                  text: 'Sign Up',
                ),

                //or continue with
                //Padding(
                //padding: const EdgeInsets.all(8.0),
                //child: Row(
                //children: [
                //Expanded(
                //child: Divider(
                //thickness: 0.5,
                //color: Colors.grey[400],
                //),
                //),
                //Padding(
                //padding: const EdgeInsets.symmetric(horizontal: 10),
                //child: Text(
                //'Or continue with',
                //style: TextStyle(color: Colors.grey[700]),
                //),
                //),
                //Expanded(
                //child: Divider(
                //thickness: 0.5,
                //color: Colors.grey[400],
                //),
                //),
                //],
                //),
                //),

                const SizedBox(height: 50),

                //google button
                //Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                //children: [
                //imagebutton(imagePath: 'lib/images/google_logo.png'),
                //],
                //),

                const SizedBox(height: 50),

                //not a member? register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
        ));
  }
}
