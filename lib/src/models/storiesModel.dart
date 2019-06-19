// To parse this JSON data, do
//
//     final story = storyFromJson(jsonString);

import 'dart:convert';

List<Story> storyFromJson(String str) => new List<Story>.from(json.decode(str).map((x) => Story.fromJson(x)));

String storyToJson(List<Story> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Story {
  String id;
  String idUser;
  String fullname;
  List<FileHeaderDto> fileHeaderDto;
  int createdDate;
  String createdBy;

  Story({
    this.id,
    this.idUser,
    this.fullname,
    this.fileHeaderDto,
    this.createdDate,
    this.createdBy,
  });

  factory Story.fromJson(Map<String, dynamic> json) => new Story(
    id: json["id"],
    idUser: json["id_user"],
    fullname: json["fullname"],
    fileHeaderDto: new List<FileHeaderDto>.from(json["fileHeaderDTO"].map((x) => FileHeaderDto.fromJson(x))),
    createdDate: json["createdDate"],
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_user": idUser,
    "fullname": fullname,
    "fileHeaderDTO": new List<dynamic>.from(fileHeaderDto.map((x) => x.toJson())),
    "createdDate": createdDate,
    "createdBy": createdBy,
  };
}

class FileHeaderDto {
  String id;
  String thumbnailUrl;
  String videoUrl;
  dynamic imgUrl;
  int createdDate;
  dynamic createdBy;

  FileHeaderDto({
    this.id,
    this.thumbnailUrl,
    this.videoUrl,
    this.imgUrl,
    this.createdDate,
    this.createdBy,
  });

  factory FileHeaderDto.fromJson(Map<String, dynamic> json) => new FileHeaderDto(
    id: json["id"],
    thumbnailUrl: json["thumbnailUrl"],
    videoUrl: json["videoUrl"],
    imgUrl: json["imgUrl"],
    createdDate: json["createdDate"],
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "thumbnailUrl": thumbnailUrl,
    "videoUrl": videoUrl,
    "imgUrl": imgUrl,
    "createdDate": createdDate,
    "createdBy": createdBy,
  };
}
