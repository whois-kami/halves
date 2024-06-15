// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class SearchingFirebaseDataSource {
  final FirebaseFirestore fireStoreDB;
  final FirebaseAuth fireAuth;
  SearchingFirebaseDataSource({
    required this.fireStoreDB,
    required this.fireAuth,
  }) : users = fireStoreDB.collection('users');

  CollectionReference users;

  Future<bool> swipeRightData({
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
      log('Swipe right completed successfully.');
      return true;
    }
    log('Swipe right completed successfully.');
    return false;
  }

  Future<int> checkNewMatchesData() async {
    var currentUserId = FirebaseAuth.instance.currentUser!.uid;
    var currentUserDoc = await users.doc(currentUserId).get();
    final int currentUserMatches =
        (currentUserDoc['matchedIds'] as List).length;

    log('Matching checked successfully.');
    return currentUserMatches;
  }

  Future<void> create({
    required uniqueId,
    required String name,
    required String description,
    required Map<String, bool> tags,
    required List<XFile?> photos,
    required String sex,
    required List<String>? likedIds,
    required List<String>? matchedIds,
  }) async {
    List<String> photoUrls = await _uploadPhotosAndGetUrls(photos);
    await users.doc(uniqueId).set({
      'name': name,
      'description': description,
      'tags': tags,
      'photo': photoUrls,
      'sex': sex,
      'likedIds': likedIds,
      'matchedIds': matchedIds,
    }).then((_) {
      log('User added successfully.');
    }).catchError((error) {
      log('Error adding user: $error');
    });
  }
}

Future<List<String>> _uploadPhotosAndGetUrls(List<XFile?> xFiles) async {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  List<String> urls = [];
  try {
    if (xFiles.isNotEmpty) {
      for (XFile? xFile in xFiles) {
        if (xFile != null) {
          Uint8List fileData = await xFile.readAsBytes();
          String dataTime = DateTime.now().millisecondsSinceEpoch.toString();
          String fileName = 'profile_photo_$dataTime.jpg';
          TaskSnapshot snapshot = await firebaseStorage
              .ref('profile_photos/$fileName')
              .putData(fileData);
          String downloadUrl = await snapshot.ref.getDownloadURL();
          urls.add(downloadUrl);
        }
      }
    }
    log('Photo loaded successfully.');
    return urls;
  } catch (e) {
    return ['e'];
  }
}
