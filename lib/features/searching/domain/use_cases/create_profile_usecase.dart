import 'package:halves/features/searching/domain/entities/user_data.dart';
import 'package:halves/features/searching/domain/repository/create_profile_repostitory.dart';

class CreateProfileUseCase {
  final CreateProfileRepository createRepository;
  CreateProfileUseCase(this.createRepository);

  Future<void> createProfile(UserProfileData personData) async {
    await createRepository.create(
      name: personData.name,
      description: personData.description,
      tags: personData.tags,
      photos: personData.photos,
    );
  }
}
