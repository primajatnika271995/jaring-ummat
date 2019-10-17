// To parse this JSON data, do
//
//     final storyByUserModel = storyByUserModelFromJson(jsonString);

import 'dart:convert';

StoryByUserModel storyByUserModelFromJson(String str) => StoryByUserModel.fromJson(json.decode(str));

String storyByUserModelToJson(StoryByUserModel data) => json.encode(data.toJson());

class StoryByUserModel {
    String userId;
    String createdBy;
    List<StoryList> storyList;

    StoryByUserModel({
        this.userId,
        this.createdBy,
        this.storyList,
    });

    factory StoryByUserModel.fromJson(Map<String, dynamic> json) => StoryByUserModel(
        userId: json["userId"] == null ? null : json["userId"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        storyList: json["storyList"] == null ? null : List<StoryList>.from(json["storyList"].map((x) => StoryList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "createdBy": createdBy == null ? null : createdBy,
        "storyList": storyList == null ? null : List<dynamic>.from(storyList.map((x) => x.toJson())),
    };
}

class StoryList {
    String id;
    int createdDate;
    dynamic resourceType;
    dynamic url;
    dynamic urlThumbnail;

    StoryList({
        this.id,
        this.createdDate,
        this.resourceType,
        this.url,
        this.urlThumbnail
    });

    factory StoryList.fromJson(Map<String, dynamic> json) => StoryList(
        id: json["id"] == null ? null : json["id"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        resourceType: json["resource_type"],
        url: json["url"],
        urlThumbnail: json["urlThumbnail"] == null ? null : json["urlThumbnail"]
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdDate": createdDate == null ? null : createdDate,
        "resource_type": resourceType,
        "url": url,
        "urlThumbnail": urlThumbnail,
    };
}
