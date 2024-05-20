import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halves/features/searching/domain/entities/user_data.dart';
import 'package:halves/features/searching/domain/use_cases/create_profile_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final CreateProfileUseCase createUseCase;

  SearchBloc({
    required this.createUseCase,
  }) : super(SearchInitial()) {
    on<CreateProfileEvent>(_createProfile);
  }

  Future<void> _createProfile(
      CreateProfileEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try {
      createUseCase.createProfile(event.user);
      emit(SearchLoaded());
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }
}
