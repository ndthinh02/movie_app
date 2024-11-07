import 'package:dio/dio.dart';
import 'package:movie_app/core/constant/app_url.dart';
import 'package:movie_app/features/home/data/models/commom_movie_model.dart';
import 'package:retrofit/http.dart';

part 'more_service.g.dart';

@RestApi(baseUrl: AppUrl.baseUrl)
abstract class MoreService {
  factory MoreService(
    Dio dio,
  ) = _MoreService;

  @GET('v1/api/{type}')
  Future<CommomMovieModel> getMoreMovie(
    @Query("limit") int limit,
    @Query("page") int page,
    @Path("type") String type,
  );


}
