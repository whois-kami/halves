// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halves/features/messaging/domain/repositories/chat_repository.dart';

class AviableContactsUsecase {
  final ChatRepository chatRepository;
  AviableContactsUsecase({
    required this.chatRepository,
  });

  Future<List<DocumentSnapshot>> getAviableContacts(
      {required String userId}) async {
    List<DocumentSnapshot> ids =
        await chatRepository.getAviableContacts(userId: userId);
    return ids;
  }
}
