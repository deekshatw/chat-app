import 'package:flutter/material.dart';
import 'package:my_chat_app/views/login_screen.dart';
import 'package:my_chat_app/views/sign_up_screen.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginScreen(
        toggle: toggleView,
      );
    } else {
      return SignUpScreen(toggle: toggleView);
    }
  }
}
