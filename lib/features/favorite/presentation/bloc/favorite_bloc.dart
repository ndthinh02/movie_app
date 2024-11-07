import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/favorite_entity.dart';
import '../../domain/use_case/favorite_usecase.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteUseCase _useCase;

  FavoriteBloc(this._useCase) : super(FavoriteInitial()) {
    on<GetListFavorite>((event, emit) => _onGetListFavorite(event, emit));
  }



  _onGetListFavorite(GetListFavorite event, Emitter emit) async {
    emit(LoadListFav());
    Future.delayed(const Duration(seconds: 2));
    final result = await _useCase.getListFav();

    result.fold((err) {
      emit(LoadListFavFailed());
    }, (data) {
      emit(
        LoadListFavSuccess(
          list: data.where((element) => element.isFav == true).toList(),
        ),
      );
    });
  }
}
