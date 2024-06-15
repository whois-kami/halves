import 'package:image_picker/image_picker.dart';

abstract class SearchingRepository {
  Future<bool> swipeRight({
    required String currentUserId,
    required String likedUserId,
  });

  Future<void> create({
    required String uniqueId,
    required String name,
    required String description,
    required Map<String, bool> tags,
    required List<XFile?> photos,
    required String sex,
    required List<String>? likedIds,
    required List<String>? matchedIds,
  });

  Future<int> checkNewMatches();
}
