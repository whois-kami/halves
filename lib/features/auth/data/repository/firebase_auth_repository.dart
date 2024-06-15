import 'package:halves/features/auth/domain/repository/auth_repository.dart';

import '../data_sources/firebase_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseDataSource firebaseDataSource;

  AuthRepositoryImpl(this.firebaseDataSource);

  @override
  Future<void> login(String email, String password) async {
    await firebaseDataSource.login(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logOut() async {
    await firebaseDataSource.logOut();
  }

  @override
  Future<void> signUp(String email, String password) async {
    await firebaseDataSource.signUp(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> resetPassword(String email) async {
    UnimplementedError('');
  }
}
