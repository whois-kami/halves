import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatRepository {
  Future<void> sendMessage({
    required String receiverId,
    required String message,
  });

  Stream<QuerySnapshot> getMessages({
    required String userId,
    required String otherId,
  });

  Future<List<DocumentSnapshot>>  getAviableContacts({
    required String userId,
  });
}
