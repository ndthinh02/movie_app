import 'package:dartz/dartz.dart';
import 'package:movie_app/features/home/domain/entities/commom_movie_entity.dart';
import 'package:movie_app/features/home/domain/entities/new_movies.dart';
import 'package:movie_app/features/home/domain/entities/series_entity.dart';

abstract class HomeRepo {
  Future<Either<Exception, NewMovieEntity>> getNewMovie();

  Future<Either<Exception, CommomMovieEntity>> getSingleMovie(int? limit);
  Future<Either<Exception, SeriesEntity>> getSeriesMovie(int? limit);
  Future<Either<Exception, CommomMovieEntity>> getCartoon(int? limit);
  Future<Either<Exception, CommomMovieEntity>> getTvShows(int? limit);
}
