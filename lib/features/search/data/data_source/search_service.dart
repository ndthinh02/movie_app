import 'package:dio/dio.dart';
import 'package:movie_app/core/constant/app_url.dart';
import 'package:movie_app/features/search/data/models/search_model.dart';
import 'package:retrofit/http.dart';

part 'search_service.g.dart';

@RestApi(baseUrl: AppUrl.baseUrl)
abstract class SearchService {
  factory SearchService(
    Dio dio,
  ) = _SearchService;

  @GET('v1/api/tim-kiem')
  Future<SearchModel> getListSearchMovie(
    @Query('keyword') String keyword,
    @Query('limit') int limit,
  );
}
