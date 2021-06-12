// Structure
// {
//   "enroll": [
//       {
//           "degree": 0,
//           "duration": ""
//       },{
//            "degree": 0,
//           "duration": ""
//       }
//       ],
//   "description": ""
// }

// "degree": 0 = ปริญญาตรี
// "degree": 1 = ปริญญาโท
// "degree": 2 = ปริญญาเอก

class AdmissionModel {
  AdmissionModel({
    this.enroll,
    this.description,
  });

  List<Enroll>? enroll;
  String? description;

  factory AdmissionModel.fromJson(Map<String, dynamic> json) => AdmissionModel(
        enroll: json["enroll"] == null
            ? null
            : List<Enroll>.from(json["enroll"].map((x) => Enroll.fromJson(x))),
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "enroll": enroll == null
            ? null
            : List<dynamic>.from(enroll!.map((x) => x.toJson())),
        "description": description == null ? null : description,
      };
}

class Enroll {
  Enroll({
    this.degree,
    this.duration,
    this.applyLink,
  });

  int? degree;
  String? duration;
  String? applyLink;

  factory Enroll.fromJson(Map<String, dynamic> json) => Enroll(
        degree: json["degree"] == null ? null : json["degree"],
        duration: json["duration"] == null ? null : json["duration"],
        applyLink: json["applyLink"] == null ? null : json["applyLink"],
      );

  Map<String, dynamic> toJson() => {
        "degree": degree == null ? null : degree,
        "duration": duration == null ? null : duration,
        "applyLink": applyLink == null ? null : applyLink,
      };
}
