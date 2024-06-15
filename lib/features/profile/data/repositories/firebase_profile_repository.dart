import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halves/features/profile/domain/repositories/profile_repository.dart';

import '../data_sources/firebase_source.dart';

class FirebaseProfileRepositoryImpl implements ProfileRepostiory {
  final ProfileFirebaseDataSource firebaseDataSource;
  FirebaseProfileRepositoryImpl(
    this.firebaseDataSource,
  );

  @override
  Future<DocumentSnapshot<Object?>> loadProfile() async {
    return await firebaseDataSource.loadProfile();
  }
}
