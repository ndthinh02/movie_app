part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {
  final bool? isSearch;

  SearchInitial({
    this.isSearch,
  });
}

final class SearchSuccess extends SearchState {
  final List<DataItems>? listSearch;
  final bool? isSearch;

  SearchSuccess({
    this.listSearch,
    this.isSearch
  });
}

final class SearchErr extends SearchState {}
