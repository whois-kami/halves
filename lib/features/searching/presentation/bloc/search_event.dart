part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class CreateProfileEvent extends SearchEvent {
  final UserProfileData user;
  const CreateProfileEvent({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class SwipeRightEvent extends SearchEvent {
  final String currentUserId;
  final String likedUserId;
  const SwipeRightEvent({
    required this.currentUserId,
    required this.likedUserId,
  });

  @override
  List<Object> get props => [
        currentUserId,
        likedUserId,
      ];
}
