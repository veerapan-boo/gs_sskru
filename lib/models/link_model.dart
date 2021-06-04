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
  final String? createDate;

  factory LinkModel.fromMap(Map<String, dynamic> json) => LinkModel(
        id: json["id"] ?? null,
        type: json["type"] ?? null,
        text: json["text"] ?? null,
        link: json["link"] ?? null,
        photoUrl: json["photoUrl"] ?? null,
        createDate: json["createDate"] ?? null,
      );

  Map<String, dynamic> toMap() => {
        "id": id ?? null,
        "type": type ?? null,
        "text": text ?? null,
        "link": link ?? null,
        "photoUrl": photoUrl ?? null,
        "createDate": createDate ?? null,
      };
}
