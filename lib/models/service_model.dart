// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

ServiceModel serviceModelFromJson(String str) =>
    ServiceModel.fromJson(json.decode(str));

String serviceModelToJson(ServiceModel data) => json.encode(data.toJson());

class ServiceModel {
  ServiceModel({
    this.id,
    this.text,
    this.link,
  });

  String? id;
  String? text;
  String? link;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json["id"] == null ? null : json["id"],
        text: json["text"] == null ? null : json["text"],
        link: json["link"] == null ? null : json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "text": text == null ? null : text,
        "link": link == null ? null : link,
      };
}
