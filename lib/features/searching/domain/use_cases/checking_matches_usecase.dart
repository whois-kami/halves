
import '../repositories/searching_repository.dart';

class CheckingMatchesUseCase {
  final SearchingRepository searchingRepository;
  CheckingMatchesUseCase(this.searchingRepository);

  Future<int> checkNewMatches() async {
    return await searchingRepository.checkNewMatches();
  }
}
