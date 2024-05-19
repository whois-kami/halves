import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:halves/features/auth/data/repository/firebase_auth_repository.dart';
import 'package:halves/features/auth/domain/repository/auth_repository.dart';
import 'package:halves/features/auth/domain/use_cases/login_usecase.dart';
import 'package:halves/features/auth/domain/use_cases/signup_usecase.dart';
import 'package:halves/features/auth/presentation/bloc/auth_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<FirebaseAuth>()),
  );

  getIt.registerLazySingleton<LoginOrLogOutUseCase>(
    () => LoginOrLogOutUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(getIt<AuthRepository>()),
  );

  getIt.registerFactory(
    () => AuthBloc(
      loginUseCase: getIt<LoginOrLogOutUseCase>(),
      signUpUseCase: getIt<SignUpUseCase>(),
    ),
  );
}
