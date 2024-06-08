part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatLoaded extends ChatState {
  final Stream<QuerySnapshot> messagesStream;

  const ChatLoaded({required this.messagesStream});

  @override
  List<Object> get props => [messagesStream];
}

final class ContactsLoaded extends ChatState {
  final List<Map<String, dynamic>> contacts;
  const ContactsLoaded({required this.contacts});

  @override
  List<Object> get props => [contacts];
}

final class ChatFailure extends ChatState {
  final String message;

  const ChatFailure({required this.message});

  @override
  List<Object> get props => [message];
}
