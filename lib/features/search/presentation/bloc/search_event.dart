part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchListMovie extends SearchEvent {
  final String keyword;
  final int limit;

  SearchListMovie({
    required this.limit,
    required this.keyword,
  });
}

class ClearListSearch extends SearchEvent {}
