import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halves/features/searching/domain/entities/user_data.dart';
import 'package:halves/features/searching/domain/use_cases/create_profile_usecase.dart';
import 'package:halves/features/searching/domain/use_cases/swipe_action_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final CreateProfileUseCase createUseCase;
  final SwipeActionsUseCase swipeActionsUseCase;
  SearchBloc({
    required this.createUseCase,
    required this.swipeActionsUseCase,
  }) : super(SearchInitial()) {
    on<CreateProfileEvent>(_createProfile);
    on<SwipeRightEvent>(_swipeRightAction);
  }

  Future<void> _createProfile(
      CreateProfileEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try {
      createUseCase.createProfile(event.user);
      emit(const SearchLoaded());
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }

  Future<void> _swipeRightAction(
      SwipeRightEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try {
      final isMatching = await swipeActionsUseCase.swipeRight(
          event.currentUserId, event.likedUserId);
      emit(SearchLoaded(isMatching: isMatching));
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }
}
