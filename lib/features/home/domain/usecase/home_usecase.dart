import 'package:dartz/dartz.dart';
import 'package:movie_app/features/home/domain/entities/commom_movie_entity.dart';
import 'package:movie_app/features/home/domain/entities/new_movies.dart';
import 'package:movie_app/features/home/domain/repositories/home_repo.dart';

class HomeUseCase {
  final HomeRepo _repo;

  HomeUseCase(this._repo);

  Future<Either<Exception, NewMovieEntity>> execute() async {
    return await _repo.getNewMovie();
  }

  Future<Either<Exception, CommomMovieEntity>> executeSingleMovie(
    int? limit,
    int? page,
  ) async {
    return await _repo.getSingleMovie(limit, page);
  }

  Future<Either<Exception, CommomMovieEntity>> executeSeriesMovie(
    int? limit,
    int? page,
  ) async {
    return await _repo.getSeriesMovie(limit, page);
  }

  Future<Either<Exception, CommomMovieEntity>> executeCartoon(
    int? limit,
    int? page,
  ) async {
    return await _repo.getCartoon(limit, page);
  }

  Future<Either<Exception, CommomMovieEntity>> executeTvShows(
    int? limit,
    int? page,
  ) async {
    return await _repo.getTvShows(limit, page);
  }
}
