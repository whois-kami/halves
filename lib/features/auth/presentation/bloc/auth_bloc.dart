import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halves/features/auth/domain/entities/user_entity.dart';
import 'package:halves/features/auth/domain/use_cases/login_usecase.dart';
import 'package:halves/features/auth/domain/use_cases/signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginOrLogOutUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.signUpUseCase,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<LoginOutEvent>(_onLoginOut);
    on<SignUpEvent>(_onSignUp);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await loginUseCase.login(event.personData);
      emit(AuthLoaded());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-email') {
        emit(AuthError(message: 'Incorrect email or password'));
      } else if (e.code == 'user-not-found') {
        emit(AuthError(message: 'User not found'));
      } else if (e.code == 'user-disabled') {
        emit(AuthError(message: 'User account is disabled'));
      } else if (e.code == 'too-many-requests') {
        emit(AuthError(message: 'Too many requests. Try again later.'));
      }
    } catch (e) {
      emit(AuthError(message: 'An unexpected error occurred'));
    }
  }

  Future<void> _onLoginOut(LoginOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await loginUseCase.loginOut();
      emit(AuthLoaded());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(message: '$e'));
    }
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await signUpUseCase.signUp(event.personData);
      emit(AuthLoaded());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(message: '$e'));
    }
  }
}
