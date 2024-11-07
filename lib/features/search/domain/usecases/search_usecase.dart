import 'package:dartz/dartz.dart';
import 'package:movie_app/features/search/domain/repositories/search_repo.dart';

import '../entites/search_entity.dart';

class SearchUseCase {
  SearchRepo _repo;

  SearchUseCase(this._repo);

  Future<Either<Exception, SearchEntity>> getListSearchMovie({
    required String keyword,
    required int limit,
  }) {
    return _repo.getListSearchMovie(keyword: keyword, limit: limit);
  }
}
