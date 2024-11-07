import 'package:dartz/dartz.dart';
import 'package:movie_app/features/detail/domain/entities/detail_entity.dart';

abstract class DetailRepo {
  Future<Either<Exception, DetailEntity>> getDetailMovie({
    required String slugMovie,
  });
}
