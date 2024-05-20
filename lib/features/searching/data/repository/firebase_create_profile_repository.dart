import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:halves/features/searching/domain/repository/create_profile_repostitory.dart';

class CreateProfileRepositoryImpl implements CreateProfileRepository {
  final FirebaseFirestore _fireStoreDB;
  CollectionReference users;

  CreateProfileRepositoryImpl(this._fireStoreDB)
      : users = _fireStoreDB.collection('users');

  @override
  Future<void> create(
      {required String name,
      required String description,
      required Map<String, bool> tags}) {
    return users.add({
      'name': name,
      'description': description,
      'tags': tags,
    });
  }
}
