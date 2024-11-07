import '../../data/model/detail_model.dart';

class DetailEntity {
  bool? status;
  String? msg;
  Movie? movie;
  List<Episodes>? episodes;

  DetailEntity({
    this.status,
    this.msg,
    this.movie,
    this.episodes,
  });
}
