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
