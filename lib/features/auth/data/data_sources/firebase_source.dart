import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseDataSource {
  final FirebaseFirestore fireStoreDB;
  final FirebaseAuth fireAuth;
  AuthFirebaseDataSource({
    required this.fireStoreDB,
    required this.fireAuth,
  }) : users = fireStoreDB.collection('users');

  CollectionReference users;

  Future<void> login({required String email, required String password}) async {
    await fireAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    log('Loging successfully.');
  }

  Future<void> logOut() async {
    await fireAuth.signOut();
    log('LogOut successfully.');
  }

  Future<void> signUp({required String email, required String password}) async {
    await fireAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    log('Sign up successfully.');
  }

  Future<void> resetPassword({required String email}) async {
    UnimplementedError('');
  }
}
