import 'package:flutter/material.dart';
import 'package:module2/components/button.dart';
//import 'package:module2/components/imagebutton.dart';
import 'package:module2/components/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //sign in function
  void signUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
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
                  AssetImage('lib/images/calculator_icon.png'),
                  color: Colors.black,
                  size: 100,
                ),

                const SizedBox(
                  height: 50,
                ),

                // welcome
                const Text(
                  'Welcome',
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

                //forgot password?
                //Padding(
                //padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //child: Row(
                //mainAxisAlignment: MainAxisAlignment.end,
                //children: [
                //Text(
                //'Forgot Password?',
                //style: TextStyle(color: Colors.grey[600]),
                //),
                //],
                //),
                //),

                //sign in button
                Button(
                  onTap: signUser,
                  text: 'Sign In',
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
                    const Text('Not a member?'),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
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
