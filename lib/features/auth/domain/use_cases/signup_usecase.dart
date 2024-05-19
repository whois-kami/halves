import 'package:halves/features/auth/domain/entities/user_entity.dart';
import 'package:halves/features/auth/domain/repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase(this.authRepository);

  Future<void> signUp(UserData personData) async {
    await authRepository.signUp(personData.email, personData.passWord);
  }
}
