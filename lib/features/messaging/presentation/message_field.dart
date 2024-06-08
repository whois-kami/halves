import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageFieldWidget extends StatelessWidget {
  final DocumentSnapshot doc;

  const MessageFieldWidget({
    super.key,
    required this.doc,
  });

  @override
  Widget build(BuildContext context) {
    final String auth = FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderId'] == auth;
    return Container(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Text(
        data['message'],
      ),
    );
  }
}
