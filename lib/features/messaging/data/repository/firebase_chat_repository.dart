// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:halves/features/messaging/domain/entities/message_entity.dart';

import 'package:halves/features/messaging/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseFirestore fireStoreDB;
  final FirebaseAuth firebaseAuth;
  ChatRepositoryImpl({
    required this.fireStoreDB,
    required this.firebaseAuth,
  });

  @override
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
  }

  @override
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
 
  @override
  Future<List<DocumentSnapshot>> getAviableContacts(
      {required String userId}) async {
    DocumentSnapshot snapshot =
        await fireStoreDB.collection('users').doc(userId).get();
    List<String> matchedIds = List<String>.from(snapshot.get('matchedIds'));

    List<DocumentSnapshot> contacts =
        await Future.wait(matchedIds.map((id) async {
      return await fireStoreDB.collection('users').doc(id).get();
    }).toList());

    return contacts;
  }
}
