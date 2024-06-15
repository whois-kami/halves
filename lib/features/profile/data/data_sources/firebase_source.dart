import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileFirebaseDataSource {
  final FirebaseFirestore fireStoreDB;
  final FirebaseAuth fireAuth;
  ProfileFirebaseDataSource({
    required this.fireStoreDB,
    required this.fireAuth,
  }) : users = fireStoreDB.collection('users');

  CollectionReference users;

  Future<DocumentSnapshot<Object?>> loadProfile() async {
    final currentUser = fireAuth.currentUser?.uid;
    if (currentUser != null) {
      log('Profile loaded successfully.');
      return await fireStoreDB.collection('users').doc(currentUser).get();
    } else {
      return throw ('not loggin');
    }
  }
}
