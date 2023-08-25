import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<QuerySnapshot<Object?>> getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: username)
        .where('username', isLessThan: username + 'z')
        .get();
  }

  uploadUserInfoToFirestore(userMap) {
    FirebaseFirestore.instance.collection('users').add(userMap);
  }

  createChatroom(String chatroomId, chatroomMap) {
    FirebaseFirestore.instance
        .collection('chatroom')
        .doc(chatroomId)
        .set(chatroomMap);
  }
}
