import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';

import '../../domain/use_case/more_use_case.dart';

part 'more_event.dart';

part 'more_state.dart';

class MoreBloc extends Bloc<MoreEvent, MoreState> {
  MoreUseCase _useCase;

  MoreBloc(this._useCase) : super(MoreInitial()) {
    on<LoadMoreSingleMovieEvent>(
      (event, emit) async {
        emit(MoreLoadingState());
        try {
          final result = await _useCase.getMoreMovie(
            limit: _pageSize,
            page: event.pageKey ?? 0,
            type: event.type ?? '',
          );

          result.fold((l) {}, (data) {
            final item = data.data?.items;
            final isLastPage = (item?.length ?? 0) < _pageSize;
            if (isLastPage) {
              event.controller?.appendLastPage(data.data?.items ?? []);
            } else {
              final nextPageKey = (event.pageKey ?? 0) + (item?.length ?? 0);
              event.controller?.appendPage(data.data?.items ?? [], nextPageKey);
            }
          });
        } catch (error) {
          event.controller?.error = error;
        }
      },
    );
  }

  final int _pageSize = 9;

  @override
  Future<void> close() {
    print("Bloc is being closed");
    return super.close();
  }
}
