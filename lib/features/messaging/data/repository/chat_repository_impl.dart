// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:halves/features/messaging/domain/repositories/chat_repository.dart';

import '../data_sources/firebase_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatFirebaseDataSource firebaseDataSource;
  ChatRepositoryImpl(
    this.firebaseDataSource,
  );

  @override
  Future<void> sendMessage(
      {required String receiverId, required String message}) async {
    await firebaseDataSource.sendMessage(
      receiverId: receiverId,
      message: message,
    );
  }

  @override
  Stream<QuerySnapshot<Object?>> getMessages(
      {required String userId, required String otherId}) {
    log('Messages loaded successfully');
    return firebaseDataSource.getMessages(
      userId: userId,
      otherId: otherId,
    );
  }

  @override
  Future<List<DocumentSnapshot>> getAviableContacts(
      {required String userId}) async {
    return await firebaseDataSource.getAviableContacts(userId: userId);
  }

  @override
  Future<DocumentSnapshot<Object?>> loadProfile(
      {required String userId}) async {
    return await firebaseDataSource.loadProfile(userId: userId);
  }
}
