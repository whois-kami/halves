// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/get_aviable_contacts_usecase.dart';
import '../../domain/use_cases/get_chat_messages_usecase.dart';
import '../../../profile/domain/use_cases/load_profile_info_usecase.dart';
import '../../domain/use_cases/send_message_usecase.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMessageUseCase sendMessageUseCase;
  final ChatMessagesUsecase getChatMessagesUseCase;
  final AviableContactsUsecase aviableContactsUsecase;
  ChatBloc({
    required this.sendMessageUseCase,
    required this.getChatMessagesUseCase,
    required this.aviableContactsUsecase,
  }) : super(ChatInitial()) {
    on<SendMessageEvent>(_sendMessage);
    on<GetChatMessagesEvent>(_getChatMessages);
    on<GetAviableContactsEvent>(_getAviableContacts);
  }

  Future<void> _sendMessage(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
      await sendMessageUseCase.sendMessage(
        receiverId: event.reciverId,
        message: event.message,
      );
    } catch (e) {
      emit(ChatFailure(message: e.toString()));
    }
    return;
  }

  void _getChatMessages(GetChatMessagesEvent event, Emitter<ChatState> emit) {
    emit(ChatLoading());
    try {
      final chatMessagesStream = getChatMessagesUseCase.getChatMessages(
        userId: event.userId,
        otherId: event.otherId,
      );

      emit(ChatLoaded(messagesStream: chatMessagesStream));
    } catch (e) {
      emit(ChatFailure(message: e.toString()));
    }
  }

  Future<void> _getAviableContacts(
      GetAviableContactsEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      final contacts =
          await aviableContactsUsecase.getAviableContacts(userId: event.userId);

      final parsedContacts = contacts.map((contact) {
        var photo = contact.get('photo');

        // if (photo is List) {
        //   photo[0];
        // } else {
        //   photo;
        // }
        return {
          'photo': photo,
          'name': contact.get('name'),
          'sex': contact.get('sex'),
          'id': contact.id
        };
      }).toList();
      emit(ContactsLoaded(contacts: parsedContacts));
    } catch (e) {
      emit(ChatFailure(message: e.toString()));
    }
  }
}
