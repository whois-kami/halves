import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halves/features/searching/domain/entities/user_data.dart';
import 'package:halves/features/searching/domain/use_cases/create_profile_usecase.dart';
import 'package:halves/features/searching/domain/use_cases/swipe_action_usecase.dart';

import '../../domain/use_cases/checking_matches_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final CreateProfileUseCase createUseCase;
  final SwipeActionsUseCase swipeActionsUseCase;
  final CheckingMatchesUseCase checkingMatchesUseCase;
  SearchBloc({
    required this.createUseCase,
    required this.swipeActionsUseCase,
    required this.checkingMatchesUseCase,
  }) : super(SearchInitial()) {
    on<CreateProfileEvent>(_createProfile);
    on<SwipeRightEvent>(_swipeRightAction);
    on<CheckingNewMatchsEvent>(_checkingMatches);
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

  Future<void> _checkingMatches(
      CheckingNewMatchsEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try {
      final newMatches = await checkingMatchesUseCase.checkNewMatches();
      emit(SearchLoaded(newMatches: true, newMatchesCount: newMatches));
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }
}
