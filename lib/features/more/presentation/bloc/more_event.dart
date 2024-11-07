part of 'more_bloc.dart';

@immutable
sealed class MoreEvent {}

class LoadMoreSingleMovieEvent extends MoreEvent {
  final int? pageKey;
  final PagingController? controller;
  final String? type;

  LoadMoreSingleMovieEvent({
    this.pageKey,
    this.controller,
    this.type,
  });
}

class CheckIfNeedMoreDataEvent extends MoreEvent {
  final int? index;

  CheckIfNeedMoreDataEvent({
    this.index,
  });
}
