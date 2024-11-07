import 'package:dartz/dartz.dart';
import 'package:movie_app/features/more/domain/repo/more_repo.dart';

import '../../../home/data/models/commom_movie_model.dart';

class MoreUseCase {
  final MoreRepo _repo;

  MoreUseCase(this._repo);

  Future<Either<Exception, CommomMovieModel>> getMoreMovie({
    required int limit,
    required int page,
    required String type,
  }) {
    return _repo.getMoreMovie(
      limit: limit,
      page: page,
      type: type,
    );
  }
}
