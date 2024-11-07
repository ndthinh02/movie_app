import 'package:dartz/dartz.dart';
import 'package:movie_app/features/home/data/models/commom_movie_model.dart';

abstract class MoreRepo {
  Future<Either<Exception, CommomMovieModel>> getMoreMovie({
    required int limit,
    required int page,
    required String type,
  });

}
