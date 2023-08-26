import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/helper/constants.dart';
import 'package:my_chat_app/services/database.dart';

class ConversationScreen extends StatefulWidget {
  final String chatroomId;
  final String chatroomName;
  const ConversationScreen(
      {super.key, required this.chatroomId, required this.chatroomName});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController messageController = TextEditingController();
  Stream<QuerySnapshot<Object?>>? chatMessagesStream;

  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatroomId).then((value) {
      setState(() {
        chatMessagesStream = value;
      });
    });
    super.initState();
  }

  Widget ChatMessageList() {
    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: chatMessagesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No messages available'));
        }

        final messages = snapshot.data!.docs;
        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final dynamic data = messages[index].data();
            final String message = (data != null) ? data['message'] : '';
            final bool sendByMe = Constants.myName == data['sendBy'];

            return MessageTile(
              message: message,
              sendByMe: sendByMe,
            );
          },
        );
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        'message': messageController.text,
        'sendBy': Constants.myName,
        'time': DateTime.now().millisecondsSinceEpoch,
      };
      databaseMethods.addConversationMessages(widget.chatroomId, messageMap);
      messageController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatroomName),
      ),
      body: Container(
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[800],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Start typing...',
                          hintStyle: TextStyle(
                            color: Colors.white54,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        sendMessage();
                      },
                      icon: Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  const MessageTile({super.key, required this.message, required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 10,
        ),
        margin: EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: sendByMe
                  ? [Color(0xff007ef4), Color(0xff2a75bc)]
                  : [Color(0x1AFFFFFF), Color(0x1AFFFFFF)],
            ),
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23),
                  )),
        child: Text(
          message,
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}
