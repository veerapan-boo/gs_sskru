import 'package:cloud_firestore/cloud_firestore.dart';

class LinkModel {
  LinkModel({
    this.id,
    this.type,
    this.text,
    this.link,
    this.photoUrl,
    this.createDate,
  });

  final String? id;
  final int? type;
  final String? text;
  final String? link;
  final String? photoUrl;
  final DateTime? createDate;

  factory LinkModel.fromMap(Map<String, dynamic> json) {
    return LinkModel(
      id: json["id"] ?? null,
      type: json["type"] ?? null,
      text: json["text"] ?? null,
      link: json["link"] ?? null,
      photoUrl: json["photoUrl"] ?? null,
      createDate: json['createDate'] is DateTime
          ? json['createDate']
          : DateTime.fromMillisecondsSinceEpoch(
              (json['createDate'] as Timestamp).millisecondsSinceEpoch),
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id ?? null,
        "type": type ?? null,
        "text": text ?? null,
        "link": link ?? null,
        "photoUrl": photoUrl ?? null,
        "createDate": createDate ?? null,
      };
}
