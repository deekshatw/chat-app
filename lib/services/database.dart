import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
  }

  uploadUserInfoToFirestore(userMap) {
    FirebaseFirestore.instance.collection('users').add(userMap);
  }
}
