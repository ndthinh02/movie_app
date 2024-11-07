import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/features/search/data/data_source/search_service.dart';
import 'package:movie_app/features/search/domain/entites/search_entity.dart';
import 'package:movie_app/features/search/domain/repositories/search_repo.dart';

class SearchImpl implements SearchRepo {
  SearchService _service;

  SearchImpl(this._service);

  @override
  Future<Either<Exception, SearchEntity>> getListSearchMovie({
    required String keyword,
    required int limit,
  }) async {
    try {
      final result = await _service.getListSearchMovie(keyword, limit);
      return right(result);
    } on DioError catch (e) {
      return left(e);
    }
  }
}
