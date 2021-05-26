import 'dart:convert';

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
      TitleLinkModel.fromJson(jsonDecode(jsonEncode(value)));
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
  });

  String text;
  String link;

  factory SubTitle.fromJson(Map<String, dynamic> json) => SubTitle(
        text: json["text"] == null ? null : json["text"],
        link: json["link"] == null ? null : json["link"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "link": link,
      };
}

Map<String, dynamic> value = {
  "data": [
    {
      "col": 0,
      "headTitle": "ข่าว",
      "subTitle": [
        {"text": "ข่าวทุนวิจัย", "link": ""},
        {"text": "ข่าวนักศึกษา", "link": ""},
        {"text": "ข่าวรับสมัคร", "link": ""}
      ]
    },
    {
      "col": 1,
      "headTitle": "เกี่ยวกับบัญฑิต",
      "subTitle": [
        {"text": "วิสัยทัศน์/พันธกิจ", "link": ""},
        {"text": "นโยบายมหาวิทยาลัย", "link": ""},
        {"text": "โครงสร้างองค์กร", "link": ""},
        {"text": "รายงานประจําปี", "link": ""},
        {"text": "งานประกันคุณภาพ", "link": ""}
      ]
    },
    {
      "col": 2,
      "headTitle": "รับสมัครนักศึกษา",
      "subTitle": [
        {"text": "ปริญญาโท", "link": ""},
        {"text": "ปริญญาเอก", "link": ""}
      ]
    },
    {
      "col": 3,
      "headTitle": "หลักสูตร",
      "subTitle": [
        {"text": "หลักสูตรระดับปริญญาเอก", "link": ""},
        {"text": "หลักสูตรระดับปริญญาโท", "link": ""},
        {"text": "ขั้นตอนการจัดทำหลักสูตร", "link": ""},
        {"text": "มคอ.2", "link": ""},
        {"text": "ระเบียบ/ประกาศเกี่ยวกับหลักสูตร", "link": ""}
      ]
    },
    {
      "col": 4,
      "headTitle": "บริการด้านวิชาการ",
      "subTitle": [
        {"text": "วิจัยและบริการวิชาการ", "link": ""},
        {"text": "วารสารวิชาการ", "link": ""},
        {"text": "ฐานข้อมูลการวิจัย", "link": ""},
        {
          "text": "งานบริการวิชาการ กิจกรรมต่าง ๆ \nที่จัดให้นักศึกษา",
          "link": ""
        }
      ]
    },
    {
      "col": 5,
      "headTitle": "บริการด้านอื่น ๆ",
      "subTitle": [
        {"text": "ปฏิทินนักศึกษา", "link": ""},
        {"text": "ข้อบังคับ/ประกาศหลักเกณฑ์", "link": ""},
        {"text": "ระเบียบ/ประกาศการเงิน", "link": ""},
        {"text": "คู่มือการทําวิทยานิพนธ์", "link": ""},
        {"text": "ดาวน์โหลดใบคําร้อง", "link": ""}
      ]
    },
    {
      "col": 6,
      "headTitle": "Staff",
      "subTitle": [
        {"text": "ผู้บริหารและบุคลากร", "link": ""},
        {"text": "คณะกรรมการบริหารหลักสูตร\nปริญญาโทและปริญญาเอก", "link": ""},
        {"text": "คณะกรรมการอำนวนการ", "link": ""}
      ]
    }
  ]
};
