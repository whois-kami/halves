import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:halves/features/auth/data/data_sources/firebase_source.dart';
import 'package:halves/features/auth/data/repository/firebase_auth_repository.dart';
import 'package:halves/features/auth/domain/repository/auth_repository.dart';
import 'package:halves/features/auth/domain/use_cases/login_usecase.dart';
import 'package:halves/features/auth/domain/use_cases/signup_usecase.dart';
import 'package:halves/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:halves/features/messaging/data/data_sources/firebase_source.dart';
import 'package:halves/features/messaging/data/repository/chat_repository_impl.dart';
import 'package:halves/features/messaging/domain/repositories/chat_repository.dart';
import 'package:halves/features/messaging/domain/use_cases/get_aviable_contacts_usecase.dart';
import 'package:halves/features/messaging/domain/use_cases/get_chat_messages_usecase.dart';
import 'package:halves/features/messaging/domain/use_cases/send_message_usecase.dart';
import 'package:halves/features/messaging/presentation/bloc/chat_bloc.dart';
import 'package:halves/features/profile/data/data_sources/firebase_source.dart';
import 'package:halves/features/profile/data/repositories/firebase_profile_repository.dart';
import 'package:halves/features/profile/domain/repositories/profile_repository.dart';
import 'package:halves/features/profile/domain/use_cases/load_profile_info_usecase.dart';
import 'package:halves/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:halves/features/searching/data/data_sources/firebase_sourse.dart';
import 'package:halves/features/searching/data/repository/searching_repository_impl.dart';
import 'package:halves/features/searching/domain/repositories/searching_repository.dart';
import 'package:halves/features/searching/domain/use_cases/checking_matches_usecase.dart';
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
    () => AuthRepositoryImpl(getIt<AuthFirebaseDataSource>()),
  );

  getIt.registerLazySingleton<AuthFirebaseDataSource>(
      () => AuthFirebaseDataSource(
            fireStoreDB: getIt<FirebaseFirestore>(),
            fireAuth: getIt<FirebaseAuth>(),
          ));

  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(getIt<ChatFirebaseDataSource>()),
  );

  getIt.registerLazySingleton<ChatFirebaseDataSource>(
      () => ChatFirebaseDataSource(
            fireStoreDB: getIt<FirebaseFirestore>(),
            fireAuth: getIt<FirebaseAuth>(),
          ));

  getIt.registerLazySingleton<ProfileRepostiory>(
    () => FirebaseProfileRepositoryImpl(
      getIt<ProfileFirebaseDataSource>(),
    ),
  );

  getIt.registerLazySingleton<ProfileFirebaseDataSource>(
      () => ProfileFirebaseDataSource(
            fireStoreDB: getIt<FirebaseFirestore>(),
            fireAuth: getIt<FirebaseAuth>(),
          ));

  getIt.registerLazySingleton<SearchingRepository>(
    () => SearchingRepositoryImpl(
      getIt<SearchingFirebaseDataSource>(),
    ),
  );

  getIt.registerLazySingleton<SearchingFirebaseDataSource>(
      () => SearchingFirebaseDataSource(
            fireStoreDB: getIt<FirebaseFirestore>(),
            fireAuth: getIt<FirebaseAuth>(),
          ));

  getIt.registerLazySingleton<LoadProfileInfoUsecase>(
    () => LoadProfileInfoUsecase(profileRepostiory: getIt<ProfileRepostiory>()),
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
    () => CreateProfileUseCase(getIt<SearchingRepository>()),
  );

  getIt.registerLazySingleton<SwipeActionsUseCase>(
    () => SwipeActionsUseCase(getIt<SearchingRepository>()),
  );

  getIt.registerLazySingleton<CheckingMatchesUseCase>(
    () => CheckingMatchesUseCase(getIt<SearchingRepository>()),
  );

  getIt.registerFactory(
    () => AuthBloc(
      loginUseCase: getIt<LoginOrLogOutUseCase>(),
      signUpUseCase: getIt<SignUpUseCase>(),
    ),
  );

  getIt.registerFactory(
    () => ProfileBloc(
      loadProfileInfoUsecase: getIt<LoadProfileInfoUsecase>(),
    ),
  );

  getIt.registerFactory(
    () => SearchBloc(
      createUseCase: getIt<CreateProfileUseCase>(),
      swipeActionsUseCase: getIt<SwipeActionsUseCase>(),
      checkingMatchesUseCase: getIt<CheckingMatchesUseCase>(),
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
