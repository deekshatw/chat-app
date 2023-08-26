import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/helper/authenticate.dart';
import 'package:my_chat_app/helper/constants.dart';
import 'package:my_chat_app/helper/helper_functions.dart';
import 'package:my_chat_app/services/auth.dart';
import 'package:my_chat_app/services/database.dart';
import 'package:my_chat_app/views/conversation_screen.dart';
import 'package:my_chat_app/views/search_screen.dart';

class ChatroomsScreen extends StatefulWidget {
  const ChatroomsScreen({super.key});

  @override
  State<ChatroomsScreen> createState() => _ChatroomsScreenState();
}

class _ChatroomsScreenState extends State<ChatroomsScreen> {
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  Stream<QuerySnapshot<Object?>>? chatroomsStream;

  Widget chatroomsList() {
    return StreamBuilder(
        stream: chatroomsStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ChatroomsTile(
                      username: snapshot.data!.docs[index]['chatroomId']
                          .toString()
                          .replaceAll('_', '')
                          .replaceAll(Constants.myName, ''),
                      chatroomId: snapshot.data!.docs[index]['chatroomId'],
                    );
                  },
                )
              : Container();
        });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = (await HelperFunctions.getUsernameSharedPreference())!;
    databaseMethods.getChatrooms(Constants.myName).then((value) {
      setState(() {
        chatroomsStream = value;
      });
    });
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
      body: chatroomsList(),
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

class ChatroomsTile extends StatelessWidget {
  final String username;
  final String chatroomId;
  const ChatroomsTile(
      {super.key, required this.username, required this.chatroomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(
                    chatroomId: chatroomId, chatroomName: username)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white24,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                username.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              username,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
