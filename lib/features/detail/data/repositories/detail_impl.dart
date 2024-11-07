import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/features/detail/data/data_source/detail_service.dart';
import 'package:movie_app/features/detail/domain/entities/detail_entity.dart';
import 'package:movie_app/features/detail/domain/repositories/detail_repo.dart';

class DetailImpl implements DetailRepo {
  DetailImpl(this._service);

  DetailService _service;

  @override
  Future<Either<Exception, DetailEntity>> getDetailMovie({
    required String slugMovie,
  }) async {
    try {
      final result = await _service.getDetailMovie(slugMovie);

      return right(result);
    } on DioError catch (e) {
      return left(e);
    }
  }
}
