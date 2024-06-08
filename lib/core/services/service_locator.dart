import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:halves/features/auth/data/repository/firebase_auth_repository.dart';
import 'package:halves/features/auth/domain/repository/auth_repository.dart';
import 'package:halves/features/auth/domain/use_cases/login_usecase.dart';
import 'package:halves/features/auth/domain/use_cases/signup_usecase.dart';
import 'package:halves/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:halves/features/messaging/data/repository/firebase_chat_repository.dart';
import 'package:halves/features/messaging/domain/repositories/chat_repository.dart';
import 'package:halves/features/messaging/domain/use_cases/get_aviable_contacts_usecase.dart';
import 'package:halves/features/messaging/domain/use_cases/get_chat_messages_usecase.dart';
import 'package:halves/features/messaging/domain/use_cases/send_message_usecase.dart';
import 'package:halves/features/messaging/presentation/bloc/chat_bloc.dart';
import 'package:halves/features/searching/data/repository/firebase_create_profile_repository.dart';
import 'package:halves/features/searching/data/repository/firebase_swipe_action_repository.dart';
import 'package:halves/features/searching/domain/repository/create_profile_repostitory.dart';
import 'package:halves/features/searching/domain/repository/swipe_actions_repository.dart';
import 'package:halves/features/searching/domain/use_cases/create_profile_usecase.dart';
import 'package:halves/features/searching/domain/use_cases/swipe_action_usecase.dart';
import 'package:halves/features/searching/presentation/bloc/search_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  getIt.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<FirebaseAuth>()),
  );

  getIt.registerLazySingleton<CreateProfileRepository>(
    () => CreateProfileRepositoryImpl(
      getIt<FirebaseFirestore>(),
      getIt<FirebaseStorage>(),
    ),
  );

  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      firebaseAuth: getIt<FirebaseAuth>(),
      fireStoreDB: getIt<FirebaseFirestore>(),
    ),
  );

  getIt.registerLazySingleton<SwipeActionsRepository>(
    () => SwipeActionsRepositoryImpl(
      getIt<FirebaseFirestore>(),
    ),
  );

  getIt.registerLazySingleton<AviableContactsUsecase>(
    () => AviableContactsUsecase(chatRepository: getIt<ChatRepository>()),
  );

  getIt.registerLazySingleton<ChatMessagesUsecase>(
    () => ChatMessagesUsecase(chatRepository: getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(chatRepository: getIt<ChatRepository>()),
  );

  getIt.registerLazySingleton<LoginOrLogOutUseCase>(
    () => LoginOrLogOutUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<CreateProfileUseCase>(
    () => CreateProfileUseCase(getIt<CreateProfileRepository>()),
  );

  getIt.registerLazySingleton<SwipeActionsUseCase>(
    () => SwipeActionsUseCase(getIt<SwipeActionsRepository>()),
  );

  getIt.registerFactory(
    () => AuthBloc(
      loginUseCase: getIt<LoginOrLogOutUseCase>(),
      signUpUseCase: getIt<SignUpUseCase>(),
    ),
  );

  getIt.registerFactory(
    () => SearchBloc(
      createUseCase: getIt<CreateProfileUseCase>(),
      swipeActionsUseCase: getIt<SwipeActionsUseCase>(),
    ),
  );

  getIt.registerFactory(
    () => ChatBloc(
      sendMessageUseCase: getIt<SendMessageUseCase>(),
      getChatMessagesUseCase: getIt<ChatMessagesUsecase>(),
      aviableContactsUsecase: getIt<AviableContactsUsecase>(),
    ),
  );
}
