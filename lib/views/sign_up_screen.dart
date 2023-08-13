// ignore_for_file: avoid_print

import 'package:my_chat_app/services/auth.dart';
import 'package:my_chat_app/views/chatrooms_screen.dart';
import 'package:my_chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignUnScreen extends StatefulWidget {
  const SignUnScreen({super.key});

  @override
  State<SignUnScreen> createState() => _SignUnScreenState();
}

class _SignUnScreenState extends State<SignUnScreen> {
  bool isLoading = false;
  AuthMethods authMethods = AuthMethods();
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController rePasswordTextEditingController =
      TextEditingController();

  signMeUp() {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      authMethods
          .signUpwithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((value) {
        print(value.userId);
        Navigator.pushReplacement(context as BuildContext,
            MaterialPageRoute(builder: (context) => const ChatroomsScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 180),
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) {
                              return val!.isEmpty || val.length < 4
                                  ? 'Please provide a valid username'
                                  : null;
                            },
                            controller: usernameTextEditingController,
                            style: const TextStyle(color: Colors.white),
                            decoration: textFieldInputDecoration('Username'),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                                      .hasMatch(val!)
                                  ? null
                                  : 'Please provide a valid email';
                            },
                            controller: emailTextEditingController,
                            style: const TextStyle(color: Colors.white),
                            decoration: textFieldInputDecoration('Email'),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            validator: (val) {
                              return val!.isEmpty || val.length < 6
                                  ? 'Please provide a valid password'
                                  : null;
                            },
                            controller: passwordTextEditingController,
                            style: const TextStyle(color: Colors.white),
                            decoration: textFieldInputDecoration('Password'),
                            obscureText: true,
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            validator: (val) {
                              return val!.isEmpty ||
                                      rePasswordTextEditingController.text !=
                                          passwordTextEditingController.text
                                  ? 'Please enter same password twice'
                                  : null;
                            },
                            controller: rePasswordTextEditingController,
                            style: const TextStyle(color: Colors.white),
                            decoration: textFieldInputDecoration('Re-Password'),
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          signMeUp();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xff145C9E),
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 20),
                          ),
                        ),
                        child: const Text(
                          'Create Account',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 20),
                          ),
                        ),
                        child: const Text(
                          'Sign Up with Google',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
