import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/features/home/data/models/commom_movie_model.dart';
import 'package:movie_app/features/more/data/data_source/more_service.dart';

import '../../domain/repo/more_repo.dart';

class MoreRepoImpl implements MoreRepo {
  MoreService _service;

  MoreRepoImpl(this._service);

  @override
  Future<Either<Exception, CommomMovieModel>> getMoreMovie({
    required int limit,
    required int page,
    required String type,
  }) async {
    try {
      final result = await _service.getMoreMovie(
        limit,
        page,
        type,
      );
      return right(result);
    } on DioError catch (e) {
      return left(e);
    }
  }
}
