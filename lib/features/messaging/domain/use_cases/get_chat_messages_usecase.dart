// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halves/features/messaging/domain/repositories/chat_repository.dart';

class ChatMessagesUsecase {
  final ChatRepository chatRepository;
  ChatMessagesUsecase({
    required this.chatRepository,
  });

  Stream<QuerySnapshot> getChatMessages({
    required String userId,
    required String otherId,
  }) =>
      chatRepository.getMessages(
        userId: userId,
        otherId: otherId,
      );
}
