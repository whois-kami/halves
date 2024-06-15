import 'package:halves/features/searching/domain/entities/user_data.dart';

import '../repositories/searching_repository.dart';

class CreateProfileUseCase {
  final SearchingRepository searchingRepository;
  CreateProfileUseCase(this.searchingRepository);

  Future<void> createProfile(UserProfileData personData) async {
    await searchingRepository.create(
      uniqueId: personData.uniqueId,
      name: personData.name,
      description: personData.description,
      tags: personData.tags,
      photos: personData.photos,
      sex: personData.sex,
      likedIds: [],
      matchedIds: [], 
    );
  }
}
