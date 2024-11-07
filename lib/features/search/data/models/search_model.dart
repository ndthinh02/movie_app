import 'package:movie_app/features/search/domain/entites/search_entity.dart';

import '../../../home/data/models/commom_movie_model.dart';

class SearchModel extends SearchEntity {
  String? status;
  String? msg;
  Data? data;

  SearchModel({this.status, this.msg, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  SeoOnPage? seoOnPage;

  String? titlePage;
  List<DataItems>? items;
  Params? params;

  Data({
    this.seoOnPage,
    this.titlePage,
    this.items,
    this.params,
  });

  Data.fromJson(Map<String, dynamic> json) {
    seoOnPage = json['seoOnPage'] != null
        ? new SeoOnPage.fromJson(json['seoOnPage'])
        : null;

    titlePage = json['titlePage'];
    if (json['items'] != null) {
      items = <DataItems>[];
      json['items'].forEach((v) {
        items!.add(new DataItems.fromJson(v));
      });
    }
    params =
        json['params'] != null ? new Params.fromJson(json['params']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.seoOnPage != null) {
      data['seoOnPage'] = this.seoOnPage!.toJson();
    }

    data['titlePage'] = this.titlePage;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.params != null) {
      data['params'] = this.params!.toJson();
    }

    return data;
  }
}
