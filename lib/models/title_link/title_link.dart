import 'dart:convert';

import 'package:gs_sskru/data/data_type.dart';

class TitleLinkModel {
  TitleLinkModel({
    this.data,
  });

  List<Data>? data;

  factory TitleLinkModel.fromJson(Map<String, dynamic> json) => TitleLinkModel(
        data: json["data"] == null
            ? null
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  TitleLinkModel get getValue =>
      TitleLinkModel.fromJson(jsonDecode(jsonEncode(dataType)));
}

class Data {
  Data({
    required this.col,
    required this.headTitle,
    required this.subTitle,
  });

  int col;
  String headTitle;
  List<SubTitle> subTitle;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        col: json["col"] == null ? null : json["col"],
        headTitle: json["headTitle"] == null ? null : json["headTitle"],
        subTitle: List<SubTitle>.from(
            json["subTitle"].map((x) => SubTitle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "col": col,
        "headTitle": headTitle,
        "subTitle": List<dynamic>.from(subTitle.map((x) => x.toJson())),
      };
}

class SubTitle {
  SubTitle({
    required this.text,
    required this.link,
    required this.type,
  });

  String text;
  String link;
  int type;

  factory SubTitle.fromJson(Map<String, dynamic> json) => SubTitle(
        text: json["text"] == null ? null : json["text"],
        link: json["link"] == null ? null : json["link"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "link": link,
        "type": type,
      };
}
