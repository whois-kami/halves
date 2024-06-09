// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}


class SendMessageEvent extends ChatEvent {
  final String message;
  final String reciverId;
  const SendMessageEvent({
    required this.message,
    required this.reciverId,
  });

  @override
  List<Object> get props => [message, reciverId];
}

class GetChatMessagesEvent extends ChatEvent {
  final String userId;
  final String otherId;
  const GetChatMessagesEvent({
    required this.userId,
    required this.otherId,
  });

  @override
  List<Object> get props => [userId, otherId];
}

class GetAviableContactsEvent extends ChatEvent {
  final String userId;
  const GetAviableContactsEvent({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}
