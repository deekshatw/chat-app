import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/services/database.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();

  QuerySnapshot<Object?>? searchSnapshot;

  initiateSearch() {
    databaseMethods
        .getUserByUsername(searchTextEditingController.text)
        .then((value) {
      setState(() {
        searchSnapshot = value;
      });
    });
  }

  createChatroomAndStartConversation(String username) {
    List<String> users = [
      username,
    ];
    databaseMethods.createChatroom();
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot?.docs.length,
            itemBuilder: (context, index) {
              return SearchTile(
                username: (searchSnapshot?.docs[index].data()
                        as dynamic)?['username'] ??
                    'No Name',
                email:
                    (searchSnapshot?.docs[index].data() as dynamic)?['email'] ??
                        'No Email',
              );
            },
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blueGrey[800],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchTextEditingController,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search username',
                          hintStyle: TextStyle(
                            color: Colors.white54,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        initiateSearch();
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              searchList()
            ],
          ),
        ),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  final String username;
  final String email;
  const SearchTile({super.key, required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(75, 97, 97, 97),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                email,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white60,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Chat',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
