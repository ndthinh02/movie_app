import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/features/home/data/data_source_remote/home_service.dart';
import 'package:movie_app/features/home/domain/entities/commom_movie_entity.dart';
import 'package:movie_app/features/home/domain/entities/new_movies.dart';
import 'package:movie_app/features/home/domain/entities/series_entity.dart';
import 'package:movie_app/features/home/domain/repositories/home_repo.dart';

class HomeImpl implements HomeRepo {
  HomeService _service;

  HomeImpl(
    this._service,
  );

  @override
  Future<Either<Exception, NewMovieEntity>> getNewMovie() async {
    try {
      final result = await _service.getNewMovie();
      return right(result);
    } on DioError catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, CommomMovieEntity>> getSingleMovie(
    int? limit,
  ) async {
    try {
      final result = await _service.getSingleMovie(
        limit ?? 10,
      );
      return right(result);
    } on DioError catch (e) {
      return left(e);
    }
  }


  @override
  Future<Either<Exception, SeriesEntity>> getSeriesMovie(
    int? limit,
  ) async {
    try {
      final result = await _service.getSeriesMovie(
        limit ?? 10,
      );
      return right(result);
    } on DioError catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, CommomMovieEntity>> getCartoon(
    int? limit,
  ) async {
    try {
      final result = await _service.getCartoon(
        limit ?? 10,
      );
      return right(result);
    } on DioError catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, CommomMovieEntity>> getTvShows(
    int? limit,
  ) async {
    try {
      final result = await _service.getTvShow(
        limit ?? 10,
      );
      return right(result);
    } on DioError catch (e) {
      return left(e);
    }
  }
}
