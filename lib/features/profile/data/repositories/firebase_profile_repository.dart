import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:halves/features/profile/domain/repositories/profile_repository.dart';

class FirebaseProfileRepositoryImpl implements ProfileRepostiory {
  final FirebaseFirestore fireStoreDB;
  final FirebaseAuth firebaseAuth;
  FirebaseProfileRepositoryImpl({
    required this.fireStoreDB,
    required this.firebaseAuth,
  });
  @override
  Future<DocumentSnapshot<Object?>> loadProfile() async {
    final currentUser = firebaseAuth.currentUser?.uid;
    if (currentUser != null) {
      return await fireStoreDB.collection('users').doc(currentUser).get();
    } else {
      return throw ('not loggin');
    }
  }
}
