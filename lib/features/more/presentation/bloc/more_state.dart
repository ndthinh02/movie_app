part of 'more_bloc.dart';

@immutable
sealed class MoreState {}

final class MoreInitial extends MoreState {}

final class MoreLoadingState extends MoreState {}

final class MoreLoadSuccessState extends MoreState {}

final class MoreLoadFailedState extends MoreState {}
