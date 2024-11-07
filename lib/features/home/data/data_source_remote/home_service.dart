import 'package:dio/dio.dart';
import 'package:movie_app/core/constant/app_url.dart';
import 'package:movie_app/features/home/data/models/commom_movie_model.dart';
import 'package:retrofit/http.dart';

import '../models/new_movie_model.dart';

part 'home_service.g.dart';

@RestApi(baseUrl: AppUrl.baseUrl)
abstract class HomeService {
  factory HomeService(
    Dio dio,
  ) = _HomeService;

  @GET('danh-sach/phim-moi-cap-nhat?page=1')
  Future<NewMovieModel> getNewMovie();

  @GET('v1/api/danh-sach/phim-le')
  Future<CommomMovieModel> getSingleMovie(
    @Query("limit") int limit,
    @Query("page") int page,
  );

  @GET('v1/api/danh-sach/phim-bo')
  Future<CommomMovieModel> getSeriesMovie(
    @Query("limit") int limit,
    @Query("page") int page,
  );

  @GET('v1/api/danh-sach/hoat-hinh')
  Future<CommomMovieModel> getCartoon(
    @Query("limit") int limit,
    @Query("page") int page,
  );

  @GET('v1/api/danh-sach/tv-shows')
  Future<CommomMovieModel> getTvShow(
    @Query("limit") int limit,
    @Query("page") int page,
  );
}
