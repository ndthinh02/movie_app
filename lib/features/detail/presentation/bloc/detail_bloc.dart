import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:event_bus/event_bus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/commom/event_bus/update_favorite.dart';
import 'package:movie_app/features/detail/domain/entities/detail_entity.dart';
import 'package:movie_app/features/favorite/domain/entity/favorite_entity.dart';

import '../../../../di.dart';
import '../../domain/usecases/detail_usecase.dart';

part 'detail_event.dart';

part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailUseCase _useCase;

  DetailBloc(
    this._useCase,
  ) : super(DetailInitial()) {
    on<LoadDetailEvent>(
      (event, emit) => _onLoadDetailEvent(event, emit),
    );
    on<AddOrRemoveFav>(
      (event, emit) => _onAddOrRemoveFavEvent(event, emit),
    );
    on<GetFavoriteEvent>(
      (event, emit) => _onGetFavoriteEvent(event, emit),
    );
  }

  bool isFav = false;
  DetailEntity detailEntity = DetailEntity();

  _onLoadDetailEvent(LoadDetailEvent event, Emitter emit) async {
    emit(DetailInitial());
    final result = await _useCase.getDetailMovie(
      slugMovie: event.slugMovie ?? '',
    );
    result.fold((err) {
      emit(
        DetailLoadErr(
          err: err.toString(),
        ),
      );
      return left(err);
    }, (data) {
      detailEntity = data;
      emit(
        DetailLoadSuccess(
          detail: data,
        ),
      );
      return right(data);
    });
  }

  _onAddOrRemoveFavEvent(AddOrRemoveFav event, Emitter emit) {
    isFav = !isFav;

    FirebaseFirestore.instance
        .collection("Favorite")
        .doc(
          FirebaseAuth.instance.currentUser!.uid,
        )
        .collection("My Favorite Movie")
        .doc(
          event.favoriteEntity?.nameMovie,
        )
        .set({
      'isFav': event.isFav,
      'slugMovie': event.favoriteEntity?.slugMovie,
      'nameMovie': event.favoriteEntity?.nameMovie,
      'urlImage': event.favoriteEntity?.urlImage,
    });
    // FavoriteEntity favorite = FavoriteEntity(
    //   isFav: event.isFav,
    //   slugMovie: event.favoriteEntity?.slugMovie,
    //   nameMovie: event.favoriteEntity?.nameMovie,
    //   urlImage: event.favoriteEntity?.urlImage,
    // );
    // int index = _listFav.indexWhere((item) => item.nameMovie == favorite.nameMovie);
    //
    // if (index != -1) {
    //   // Nếu tìm thấy tên trùng, cập nhật giá trị của phần tử đó
    //   _listFav[index] = favorite;
    // } else {
    //   // Nếu không tìm thấy tên trùng, thêm phần tử mới
    //   _listFav.add(favorite);
    // }
    // print('---------------lít fav $_listFav');
    // _listFav.forEach((element) {print(element.nameMovie);});
    emit(
      DetailLoadSuccess(
        detail: detailEntity,
        isFav: isFav,
      ),
    );
    getIt<EventBus>().fire(UpdateFavorite());
  }

  _onGetFavoriteEvent(GetFavoriteEvent event, Emitter emit) async {
    final favorite = await FirebaseFirestore.instance
        .collection("Favorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Favorite Movie")
        .doc(event.name ?? '')
        .get();
    emit(
      DetailLoadSuccess(
        detail: detailEntity,
        isFav: favorite.get("isFav"),
      ),
    );
    print('object ${favorite.get("isFav")}');
  }
}
