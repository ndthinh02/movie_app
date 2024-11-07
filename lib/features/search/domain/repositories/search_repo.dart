import 'package:dartz/dartz.dart';
import 'package:movie_app/features/search/domain/entites/search_entity.dart';

abstract class SearchRepo {
  Future<Either<Exception, SearchEntity>> getListSearchMovie({
    required String keyword,
    required int limit,
  });
}
