// To parse this JSON data, do
//
//     final jelajahKebaikanModel = jelajahKebaikanModelFromJson(jsonString);

import 'dart:convert';

List<JelajahKebaikanModel> jelajahKebaikanModelFromJson(String str) => List<JelajahKebaikanModel>.from(json.decode(str).map((x) => JelajahKebaikanModel.fromJson(x)));

String jelajahKebaikanModelToJson(List<JelajahKebaikanModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JelajahKebaikanModel {
  String id;
  String description;
  String createdBy;
  String totallikes;
  String category;
  List<ImageContent> imageContent;

  JelajahKebaikanModel({
    this.id,
    this.description,
    this.createdBy,
    this.totallikes,
    this.category,
    this.imageContent,
  });

  factory JelajahKebaikanModel.fromJson(Map<String, dynamic> json) => JelajahKebaikanModel(
    id: json["id"] == null ? null : json["id"],
    description: json["description"] == null ? null : json["description"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    totallikes: json["totallikes"] == null ? null : json["totallikes"],
    category: json["category"] == null ? null : json["category"],
    imageContent: json["imageContent"] == null ? null : List<ImageContent>.from(json["imageContent"].map((x) => ImageContent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "description": description == null ? null : description,
    "createdBy": createdBy == null ? null : createdBy,
    "totallikes": totallikes == null ? null : totallikes,
    "category": category == null ? null : category,
    "imageContent": imageContent == null ? null : List<dynamic>.from(imageContent.map((x) => x.toJson())),
  };
}

class ImageContent {
  String id;
  String idUser;
  String resourceType;
  String urlType;
  String url;
  int createdDate;
  String createdBy;
  String urlThumbnail;
  String publicId;
  String formatFile;

  ImageContent({
    this.id,
    this.idUser,
    this.resourceType,
    this.urlType,
    this.url,
    this.createdDate,
    this.createdBy,
    this.urlThumbnail,
    this.publicId,
    this.formatFile,
  });

  factory ImageContent.fromJson(Map<String, dynamic> json) => ImageContent(
    id: json["id"] == null ? null : json["id"],
    idUser: json["idUser"] == null ? null : json["idUser"],
    resourceType: json["resourceType"] == null ? null : json["resourceType"],
    urlType: json["urlType"] == null ? null : json["urlType"],
    url: json["url"] == null ? null : json["url"],
    createdDate: json["createdDate"] == null ? null : json["createdDate"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    urlThumbnail: json["urlThumbnail"] == null ? null : json["urlThumbnail"],
    publicId: json["publicId"] == null ? null : json["publicId"],
    formatFile: json["formatFile"] == null ? null : json["formatFile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "idUser": idUser == null ? null : idUser,
    "resourceType": resourceType == null ? null : resourceType,
    "urlType": urlType == null ? null : urlType,
    "url": url == null ? null : url,
    "createdDate": createdDate == null ? null : createdDate,
    "createdBy": createdBy == null ? null : createdBy,
    "urlThumbnail": urlThumbnail == null ? null : urlThumbnail,
    "publicId": publicId == null ? null : publicId,
    "formatFile": formatFile == null ? null : formatFile,
  };
}
