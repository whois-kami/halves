import 'package:halves/features/searching/domain/repository/swipe_actions_repository.dart';

class SwipeActionsUseCase {
  final SwipeActionsRepository swipeRepository;
  SwipeActionsUseCase(this.swipeRepository);

  Future<bool> swipeRight(String currentUserId, String likedUserId) async {
    return await swipeRepository.swipeRight(
      currentUserId: currentUserId,
      likedUserId: likedUserId,
    );
  }
}
