// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {}

class LoginEvent extends AuthEvent {
  final UserData personData;

  LoginEvent({required this.personData});

  @override
  List<Object?> get props => [personData];
}

class LoginOutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignUpEvent extends AuthEvent {
  final UserData personData;
  SignUpEvent({
    required this.personData,
  });
  @override
  List<Object?> get props => throw UnimplementedError();
}
