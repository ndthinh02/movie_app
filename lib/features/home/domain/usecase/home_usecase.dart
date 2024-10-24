import 'package:dartz/dartz.dart';
import 'package:movie_app/features/home/domain/entities/commom_movie_entity.dart';
import 'package:movie_app/features/home/domain/entities/new_movies.dart';
import 'package:movie_app/features/home/domain/entities/series_entity.dart';
import 'package:movie_app/features/home/domain/repositories/home_repo.dart';

class HomeUseCase {
  final HomeRepo _repo;

  HomeUseCase(this._repo);

  Future<Either<Exception, NewMovieEntity>> execute() async {
    return await _repo.getNewMovie();
  }

  Future<Either<Exception, CommomMovieEntity>> executeSingleMovie(
    int? limit,
  ) async {
    return await _repo.getSingleMovie(limit);
  }

  Future<Either<Exception, SeriesEntity>> executeSeriesMovie(
    int? limit,
  ) async {
    return await _repo.getSeriesMovie(limit);
  }

  Future<Either<Exception, CommomMovieEntity>> executeCartoon(
    int? limit,
  ) async {
    return await _repo.getCartoon(limit);
  }

  Future<Either<Exception, CommomMovieEntity>> executeTvShows(
    int? limit,
  ) async {
    return await _repo.getTvShows(limit);
  }
}
