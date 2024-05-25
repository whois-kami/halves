import 'package:image_picker/image_picker.dart';

class UserProfileData {
  String name;
  String description;
  Map<String, bool> tags;
  List<XFile?> photos;
  String sex;
  UserProfileData({
    required this.name,
    required this.description,
    required this.tags,
    required this.photos,
    required this.sex,
  });
}
