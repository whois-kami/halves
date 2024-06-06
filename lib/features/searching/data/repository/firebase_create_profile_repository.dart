import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:halves/features/searching/domain/repository/create_profile_repostitory.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfileRepositoryImpl implements CreateProfileRepository {
  final FirebaseFirestore _fireStoreDB;
  final FirebaseStorage _firebaseStorage;

  CollectionReference users;

  CreateProfileRepositoryImpl(this._fireStoreDB, this._firebaseStorage)
      : users = _fireStoreDB.collection('users');

  @override
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

  Future<List<String>> _uploadPhotosAndGetUrls(List<XFile?> xFiles) async {
    List<String> urls = [];
    try {
      if (xFiles.isNotEmpty) {
        for (XFile? xFile in xFiles) {
          if (xFile != null) {
            Uint8List fileData = await xFile.readAsBytes();
            String dataTime = DateTime.now().millisecondsSinceEpoch.toString();
            String fileName = 'profile_photo_$dataTime.jpg';
            TaskSnapshot snapshot = await _firebaseStorage
                .ref('profile_photos/$fileName')
                .putData(fileData);
            String downloadUrl = await snapshot.ref.getDownloadURL();
            urls.add(downloadUrl);
          }
        }
      }
      return urls;
    } catch (e) {
      return ['e'];
    }
  }
}
