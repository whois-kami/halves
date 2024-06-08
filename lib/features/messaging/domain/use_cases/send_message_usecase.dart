// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:halves/features/messaging/domain/repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository chatRepository;
  SendMessageUseCase({
    required this.chatRepository,
  });

  Future<void> sendMessage(
          {required String receiverId, required String message}) async =>
      chatRepository.sendMessage(
        receiverId: receiverId,
        message: message,
      );
}
