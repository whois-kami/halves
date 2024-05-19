import 'package:halves/features/auth/domain/entities/user_entity.dart';
import 'package:halves/features/auth/domain/repository/auth_repository.dart';

class LoginOrLogOutUseCase {
  final AuthRepository authRepository;

  LoginOrLogOutUseCase(this.authRepository);

  Future<void> login(UserData personData) async {
    await authRepository.login(personData.email, personData.passWord);
  }

  Future<void> loginOut() async {
    await authRepository.logOut();
  }
}