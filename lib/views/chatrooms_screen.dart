import 'package:flutter/material.dart';
import 'package:my_chat_app/helper/authenticate.dart';
import 'package:my_chat_app/helper/constants.dart';
import 'package:my_chat_app/helper/helper_functions.dart';
import 'package:my_chat_app/services/auth.dart';
import 'package:my_chat_app/views/search_screen.dart';

class ChatroomsScreen extends StatefulWidget {
  const ChatroomsScreen({super.key});

  @override
  State<ChatroomsScreen> createState() => _ChatroomsScreenState();
}

class _ChatroomsScreenState extends State<ChatroomsScreen> {
  AuthMethods authMethods = AuthMethods();
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = (await HelperFunctions.getUsernameSharedPreference())!;
  }

  @override
  Widget build(BuildContext context) {
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
