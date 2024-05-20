abstract class CreateProfileRepository {
  Future<void> create({
    required String name,
    required String description,
    required Map<String, bool> tags,
  });
}
