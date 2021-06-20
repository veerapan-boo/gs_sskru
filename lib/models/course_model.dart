class CourseModel {
  CourseModel({
    this.id,
    this.link,
    this.text,
    this.title,
  });

  String? id;
  String? link;
  String? text;
  String? title;

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        id: json["id"] == null ? null : json["id"],
        link: json["link"] == null ? null : json["link"],
        text: json["text"] == null ? null : json["text"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "link": link == null ? null : link,
        "text": text == null ? null : text,
        "title": text == null ? null : title,
      };
}
