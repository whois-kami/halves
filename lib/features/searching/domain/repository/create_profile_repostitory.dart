import 'package:image_picker/image_picker.dart';

abstract class CreateProfileRepository {
  Future<void> create({
    required String name,
    required String description,
    required Map<String, bool> tags,
    required List<XFile?> photos,
    required String sex,
  });
}
