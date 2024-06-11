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
    return Row(
      mainAxisAlignment:
          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          alignment:
              isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
          decoration: BoxDecoration(
            color:
                isCurrentUser ? const Color(0xFF644E9F) : Colors.grey.shade500,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
          child: Text(
            data['message'],
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
