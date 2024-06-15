
import '../repositories/searching_repository.dart';

class SwipeActionsUseCase {
  final SearchingRepository searchingRepository;
  SwipeActionsUseCase(this.searchingRepository);

  Future<bool> swipeRight(String currentUserId, String likedUserId) async {
    return await searchingRepository.swipeRight(
      currentUserId: currentUserId,
      likedUserId: likedUserId,
    );
  }
}
