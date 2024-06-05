abstract class SwipeActionsRepository {
  Future<bool> swipeRight({
    required String currentUserId,
    required String likedUserId,
  });
}
