import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halves/features/searching/domain/repository/swipe_actions_repository.dart';

class SwipeActionsRepositoryImpl implements SwipeActionsRepository {
  final FirebaseFirestore _fireStoreDB;

  CollectionReference users;

  SwipeActionsRepositoryImpl(this._fireStoreDB)
      : users = _fireStoreDB.collection('users');

  @override
  Future<bool> swipeRight({
    required String currentUserId,
    required String likedUserId,
  }) async {
    // Fetch current user data from Firestore
    var currentUserDoc = await users.doc(currentUserId).get();
    var currentUserData = currentUserDoc.data() as Map<String, dynamic>? ?? {};
    List<String> currentUserLikedIds =
        List<String>.from(currentUserData['likedIds'] ?? []);

    // Fetch liked user data from Firestore
    var likedUserDoc = await users.doc(likedUserId).get();
    var likedUserData = likedUserDoc.data() as Map<String, dynamic>? ?? {};
    List<String> likedUserLikedIds =
        List<String>.from(likedUserData['likedIds'] ?? []);

    // Check if the current user has already liked the liked user
    if (!currentUserLikedIds.contains(likedUserId)) {
      currentUserLikedIds.add(likedUserId);
      await users.doc(currentUserId).update({'likedIds': currentUserLikedIds});
    }

    // Check if the liked user has liked the current user
    if (likedUserLikedIds.contains(currentUserId)) {
      List<String> currentUserMatchedIds =
          List<String>.from(currentUserData['matchedIds'] ?? []);
      List<String> likedUserMatchedIds =
          List<String>.from(likedUserData['matchedIds'] ?? []);

      // Update matchedIds for both users
      if (!currentUserMatchedIds.contains(likedUserId)) {
        currentUserMatchedIds.add(likedUserId);
        await users
            .doc(currentUserId)
            .update({'matchedIds': currentUserMatchedIds});
      }

      if (!likedUserMatchedIds.contains(currentUserId)) {
        likedUserMatchedIds.add(currentUserId);
        await users
            .doc(likedUserId)
            .update({'matchedIds': likedUserMatchedIds});
      }
      return true;
    }

    return false;
  }
}
