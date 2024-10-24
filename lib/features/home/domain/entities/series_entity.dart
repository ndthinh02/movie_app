import '../../data/models/series_model.dart';

class SeriesEntity {
  String? status;
  String? msg;
  DataSeries? data;

  SeriesEntity({
    this.status,
    this.msg,
    this.data,
  });
}
