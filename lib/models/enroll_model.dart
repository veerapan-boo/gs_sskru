// To parse this JSON data, do
//
//     final enrollModel = enrollModelFromJson(jsonString);

import 'dart:convert';

Map<String, EnrollModel> enrollModelFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, EnrollModel>(k, EnrollModel.fromJson(v)));

String enrollModelToJson(Map<String, EnrollModel> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class EnrollModel {
  EnrollModel({
    this.duration,
    this.type,
    this.applyLink,
  });

  String? duration;
  int? type;
  String? applyLink;

  factory EnrollModel.fromJson(Map<String, dynamic> json) => EnrollModel(
        duration: json["duration"] == null ? null : json["duration"],
        type: json["type"] == null ? null : json["type"],
        applyLink: json["applyLink"] == null ? null : json["applyLink"],
      );

  Map<String, dynamic> toJson() => {
        "duration": duration == null ? null : duration,
        "type": type == null ? null : type,
        "applyLink": applyLink == null ? null : applyLink,
      };
}
