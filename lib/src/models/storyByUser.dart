// To parse this JSON data, do
//
//     final storyByUser = storyByUserFromJson(jsonString);

import 'dart:convert';

StoryByUser storyByUserFromJson(String str) => StoryByUser.fromJson(json.decode(str));

String storyByUserToJson(StoryByUser data) => json.encode(data.toJson());

class StoryByUser {
  String userId;
  String createdBy;
  List<StoryList> storyList;

  StoryByUser({
    this.userId,
    this.createdBy,
    this.storyList,
  });

  factory StoryByUser.fromJson(Map<String, dynamic> json) => new StoryByUser(
    userId: json["userId"],
    createdBy: json["createdBy"],
    storyList: new List<StoryList>.from(json["storyList"].map((x) => StoryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "createdBy": createdBy,
    "storyList": new List<dynamic>.from(storyList.map((x) => x.toJson())),
  };
}

class StoryList {
  String id;
  int createdDate;
  List<Content> contents;

  StoryList({
    this.id,
    this.createdDate,
    this.contents,
  });

  factory StoryList.fromJson(Map<String, dynamic> json) => new StoryList(
    id: json["id"],
    createdDate: json["createdDate"],
    contents: new List<Content>.from(json["contents"].map((x) => Content.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdDate": createdDate,
    "contents": new List<dynamic>.from(contents.map((x) => x.toJson())),
  };
}

class Content {
  String id;
  String thumbnailUrl;
  String videoUrl;
  String imgUrl;
  int createdDate;
  dynamic createdBy;

  Content({
    this.id,
    this.thumbnailUrl,
    this.videoUrl,
    this.imgUrl,
    this.createdDate,
    this.createdBy,
  });

  factory Content.fromJson(Map<String, dynamic> json) => new Content(
    id: json["id"],
    thumbnailUrl: json["thumbnailUrl"] == null ? null : json["thumbnailUrl"],
    videoUrl: json["videoUrl"] == null ? null : json["videoUrl"],
    imgUrl: json["imgUrl"] == null ? null : json["imgUrl"],
    createdDate: json["createdDate"],
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,
    "videoUrl": videoUrl == null ? null : videoUrl,
    "imgUrl": imgUrl == null ? null : imgUrl,
    "createdDate": createdDate,
    "createdBy": createdBy,
  };
}
