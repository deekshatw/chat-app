import 'package:flutter/material.dart';
import 'package:my_chat_app/helper/authenticate.dart';
import 'package:my_chat_app/services/auth.dart';
import 'package:my_chat_app/views/search_screen.dart';

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
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Authenticate(),
                  ));
            },
            icon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const SearchScreen())));
        },
        child: const Icon(
          Icons.search,
        ),
      ),
    );
  }
}
