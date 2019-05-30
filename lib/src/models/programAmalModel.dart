// To parse this JSON data, do
//
//     final programAmalModel = programAmalModelFromJson(jsonString);

import 'dart:convert';

List<ProgramAmalModel> programAmalModelFromJson(String str) => new List<ProgramAmalModel>.from(json.decode(str).map((x) => ProgramAmalModel.fromJson(x)));

String programAmalModelToJson(List<ProgramAmalModel> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class ProgramAmalModel {
  String id;
  String idUser;
  dynamic idUserLike;
  String titleProgram;
  String category;
  String endDonasi;
  double targetDonasi;
  double totalDonasi;
  String descriptionProgram;
  List<String> imageContent;
  int createdDate;
  String createdBy;
  int totalComment;
  int totalLikes;

  ProgramAmalModel({
    this.id,
    this.idUser,
    this.idUserLike,
    this.titleProgram,
    this.category,
    this.endDonasi,
    this.targetDonasi,
    this.totalDonasi,
    this.descriptionProgram,
    this.imageContent,
    this.createdDate,
    this.createdBy,
    this.totalComment,
    this.totalLikes,
  });

  factory ProgramAmalModel.fromJson(Map<String, dynamic> json) => new ProgramAmalModel(
    id: json["id"],
    idUser: json["idUser"],
    idUserLike: json["idUserLike"],
    titleProgram: json["titleProgram"],
    category: json["category"],
    endDonasi: json["endDonasi"],
    targetDonasi: json["targetDonasi"],
    totalDonasi: json["totalDonasi"],
    descriptionProgram: json["descriptionProgram"],
    imageContent: new List<String>.from(json["imageContent"].map((x) => x == null ? null : x)),
    createdDate: json["createdDate"],
    createdBy: json["createdBy"],
    totalComment: json["total_comment"],
    totalLikes: json["total_likes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idUser": idUser,
    "idUserLike": idUserLike,
    "titleProgram": titleProgram,
    "category": category,
    "endDonasi": endDonasi,
    "targetDonasi": targetDonasi,
    "totalDonasi": totalDonasi,
    "descriptionProgram": descriptionProgram,
    "imageContent": new List<dynamic>.from(imageContent.map((x) => x == null ? null : x)),
    "createdDate": createdDate,
    "createdBy": createdBy,
    "total_comment": totalComment,
    "total_likes": totalLikes,
  };
}
