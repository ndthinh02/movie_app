import 'package:dartz/dartz.dart';
import 'package:movie_app/features/detail/domain/entities/detail_entity.dart';
import 'package:movie_app/features/detail/domain/repositories/detail_repo.dart';

class DetailUseCase {
  DetailRepo _repo;

  DetailUseCase(this._repo);

  Future<Either<Exception, DetailEntity>> getDetailMovie({
    required String slugMovie,
  }) {
    return _repo.getDetailMovie(slugMovie: slugMovie);
  }
}
