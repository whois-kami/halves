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
  final bool? isMatching;
    final bool? newMatches;

  final int? newMatchesCount;
  @override
  List<Object> get props => [];

  const SearchLoaded({
    this.isMatching,
    this.newMatches,
    this.newMatchesCount,
  });
}

final class SearchError extends SearchState {
  final String message;

  const SearchError({required this.message});

  @override
  List<Object> get props => [message];
}
