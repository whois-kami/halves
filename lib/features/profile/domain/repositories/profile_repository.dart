import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProfileRepostiory {
  Future<DocumentSnapshot> loadProfile();
}
