import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halves/features/profile/domain/use_cases/load_profile_info_usecase.dart';

import '../../domain/entities/profile_entity.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final LoadProfileInfoUsecase loadProfileInfoUsecase;
  ProfileBloc({
    required this.loadProfileInfoUsecase,
  }) : super(ProfileInitial()) {
    on<LoadProfileInfoEvent>(_loadProfile);
  }

  Future<void> _loadProfile(
      LoadProfileInfoEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await loadProfileInfoUsecase.loadProfile();
      var photo = profile.get('photo');

      // if (photo is List) {
      //   photo[0];
      // } else {
      //   photo;
      // }
      final userProfile = Profile(
        name: profile.get('name'),
        photos: photo,
        description: profile.get('description'),
        likedIds: profile.get('likedIds'),
        matchedIds: profile.get('matchedIds'),
        sex: profile.get('sex'),
        tags: profile.get('tags'),
      );
      emit(ProfileLoaded(profile: userProfile));
    } catch (e) {
      emit(ProfileFailure(errorMessage: e.toString()));
    }
  }
}
