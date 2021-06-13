// To parse this JSON data, do
//
//     final admissionDetailModel = admissionDetailModelFromJson(jsonString);

import 'dart:convert';

AdmissionDetailModel admissionDetailModelFromJson(String str) => AdmissionDetailModel.fromJson(json.decode(str));

String admissionDetailModelToJson(AdmissionDetailModel data) => json.encode(data.toJson());

class AdmissionDetailModel {
  AdmissionDetailModel({
    this.description,
  });

  String? description;

  factory AdmissionDetailModel.fromJson(Map<String, dynamic> json) => AdmissionDetailModel(
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "description": description == null ? null : description,
      };
}
