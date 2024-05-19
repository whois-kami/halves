part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {}

final class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthLoaded extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
  @override
  List<Object?> get props => [message];
}
