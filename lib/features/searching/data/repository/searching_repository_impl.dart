// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:halves/features/searching/data/data_sources/firebase_sourse.dart';
import 'package:halves/features/searching/domain/repositories/searching_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchingRepositoryImpl implements SearchingRepository {
  SearchingFirebaseDataSource firebaseDataSource;
  SearchingRepositoryImpl(
    this.firebaseDataSource,
  );
  @override
  Future<int> checkNewMatches() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? lastCheck = prefs.getString('last_check_timestamp');
    final DateTime now = DateTime.now();

    final int currentUserMatches =
        await firebaseDataSource.checkNewMatchesData();
    final int? lastMatches = prefs.getInt('last_matches_count');

    if (lastCheck != null) {
      final DateTime lastCheckDate = DateTime.parse(lastCheck);

      if (now.isAfter(lastCheckDate)) {
        if (lastMatches == null) {
          await prefs.setInt('last_matches_count', currentUserMatches);
          await prefs.setString('last_check_timestamp', now.toIso8601String());
          return 0;
        } else {
          if (lastMatches < currentUserMatches) {
            final int newMatches = currentUserMatches - lastMatches;
            await prefs.setInt('last_matches_count', currentUserMatches);
            await prefs.setString(
                'last_check_timestamp', now.toIso8601String());
            return newMatches;
          } else {
            await prefs.setString(
                'last_check_timestamp', now.toIso8601String());
            return 0;
          }
        }
      }
    } else {
      await prefs.setInt('last_matches_count', currentUserMatches);
      await prefs.setString('last_check_timestamp', now.toIso8601String());
      return 0;
    }
    return 0;
  }

  @override
  Future<void> create(
      {required uniqueId,
      required String name,
      required String description,
      required Map<String, bool> tags,
      required List<XFile?> photos,
      required String sex,
      required List<String>? likedIds,
      required List<String>? matchedIds}) async {
    await firebaseDataSource.create(
      uniqueId: uniqueId,
      name: name,
      description: description,
      tags: tags,
      photos: photos,
      sex: sex,
      likedIds: likedIds,
      matchedIds: matchedIds,
    );
  }

  @override
  Future<bool> swipeRight(
      {required String currentUserId, required String likedUserId}) async {
    // Fetch current user data from Firestore
    return firebaseDataSource.swipeRightData(
      currentUserId: currentUserId,
      likedUserId: likedUserId,
    );
  }
}
