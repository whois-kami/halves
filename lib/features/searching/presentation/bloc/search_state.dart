part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

final class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

final class SearchLoaded extends SearchState {
  @override
  List<Object> get props => [];
}

final class SearchError extends SearchState {
  final String message;

  const SearchError({required this.message});

  @override
  List<Object> get props => [message];
}
