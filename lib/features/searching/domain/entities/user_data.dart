// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:image_picker/image_picker.dart';

class UserProfileData {
  String name;
  String description;
  Map<String, bool> tags;
  List<XFile?> photos;
  String sex;
  List<String> likedIds; 
  List<String> matchedIds; 

  UserProfileData({
    required this.name,
    required this.description,
    required this.tags,
    required this.photos,
    required this.sex,
    required this.likedIds,
    required this.matchedIds,
  });

  UserProfileData copyWith({
    String? name,
    String? description,
    Map<String, bool>? tags,
    List<XFile?>? photos,
    String? sex,
    List<String>? likedIds,
    List<String>? matchedIds,
  }) {
    return UserProfileData(
      name: name ?? this.name,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      photos: photos ?? this.photos,
      sex: sex ?? this.sex,
      likedIds: likedIds ?? this.likedIds,
      matchedIds: matchedIds ?? this.matchedIds,
    );
  }
}
