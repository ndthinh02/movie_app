import 'package:dio/dio.dart';
import 'package:movie_app/core/constant/app_url.dart';
import 'package:movie_app/features/detail/data/model/detail_model.dart';
import 'package:retrofit/http.dart';

part 'detail_service.g.dart';

@RestApi(baseUrl: AppUrl.baseUrl)
abstract class DetailService {
  factory DetailService(
    Dio dio,
  ) = _DetailService;

  @GET('phim/{slugMovie}')
  Future<DetailModel> getDetailMovie(
    @Path('slugMovie') String slugMovie,
  );
}
