import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/message_entity.dart';

class ChatFirebaseDataSource {
  final FirebaseFirestore fireStoreDB;
  final FirebaseAuth fireAuth;
  ChatFirebaseDataSource({
    required this.fireStoreDB,
    required this.fireAuth,
  }) : users = fireStoreDB.collection('users');

  CollectionReference users;

  Future<void> sendMessage(
      {required String receiverId, required String message}) async {
    final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final String currentEmail = FirebaseAuth.instance.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentEmail,
      reciverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await fireStoreDB
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
    log('Message sended successfully.');
  }

  Stream<QuerySnapshot<Object?>> getMessages(
      {required String userId, required String otherId}) {
    List<String> ids = [userId, otherId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return fireStoreDB
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<List<DocumentSnapshot>> getAviableContacts(
      {required String userId}) async {
    DocumentSnapshot snapshot =
        await fireStoreDB.collection('users').doc(userId).get();
    List<String> matchedIds = List<String>.from(snapshot.get('matchedIds'));

    List<DocumentSnapshot> contacts =
        await Future.wait(matchedIds.map((id) async {
      return await fireStoreDB.collection('users').doc(id).get();
    }).toList());

    log('Aviable contacts loaded successfully.');
    return contacts;
  }

  Future<DocumentSnapshot<Object?>> loadProfile(
      {required String userId}) async {
    log('Messaging profile loaded successfully.');
    return await fireStoreDB.collection('users').doc(userId).get();
  }
}
