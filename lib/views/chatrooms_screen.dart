import 'package:flutter/material.dart';
import 'package:my_chat_app/services/auth.dart';
import 'package:my_chat_app/views/sign_up_screen.dart';

class ChatroomsScreen extends StatelessWidget {
  const ChatroomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthMethods authMethods = AuthMethods();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatrooms'),
        actions: [
          IconButton(
            onPressed: () {
              authMethods.signOut();
              Navigator.pushReplacementNamed(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignUnScreen();
                    },
                  ) as String);
            },
            icon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      body: Center(child: Text('hello world')),
    );
  }
}
