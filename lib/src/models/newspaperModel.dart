// To parse this JSON data, do
//
//     final newspaper = newspaperFromJson(jsonString);

import 'dart:convert';

List<Newspaper> newspaperFromJson(String str) => new List<Newspaper>.from(json.decode(str).map((x) => Newspaper.fromJson(x)));

String newspaperToJson(List<Newspaper> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Newspaper {
  String id;
  String idUser;
  dynamic idUserLike;
  String title;
  String category;
  String description;
  List<String> imageContent;
  int createdDate;
  String createdBy;
  int totalComment;
  int totalLikes;

  Newspaper({
    this.id,
    this.idUser,
    this.idUserLike,
    this.title,
    this.category,
    this.description,
    this.imageContent,
    this.createdDate,
    this.createdBy,
    this.totalComment,
    this.totalLikes,
  });

  factory Newspaper.fromJson(Map<String, dynamic> json) => new Newspaper(
    id: json["id"],
    idUser: json["idUser"],
    idUserLike: json["idUserLike"],
    title: json["title"],
    category: json["category"],
    description: json["description"],
    imageContent: new List<String>.from(json["imageContent"].map((x) => x)),
    createdDate: json["createdDate"],
    createdBy: json["createdBy"],
    totalComment: json["totalComment"],
    totalLikes: json["totalLikes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idUser": idUser,
    "idUserLike": idUserLike,
    "title": title,
    "category": category,
    "description": description,
    "imageContent": new List<dynamic>.from(imageContent.map((x) => x)),
    "createdDate": createdDate,
    "createdBy": createdBy,
    "totalComment": totalComment,
    "totalLikes": totalLikes,
  };
}
