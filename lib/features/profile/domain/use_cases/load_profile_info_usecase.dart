import 'package:cloud_firestore/cloud_firestore.dart';

import '../repositories/profile_repository.dart';

class LoadProfileInfoUsecase {
  final ProfileRepostiory profileRepostiory;
  LoadProfileInfoUsecase({
    required this.profileRepostiory,
  });

  Future<DocumentSnapshot> loadProfile() async => profileRepostiory.loadProfile();
}
