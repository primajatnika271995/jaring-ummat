// To parse this JSON data, do
//
//     final allStoryModel = allStoryModelFromJson(jsonString);

import 'dart:convert';

List<AllStoryModel> allStoryModelFromJson(String str) => List<AllStoryModel>.from(json.decode(str).map((x) => AllStoryModel.fromJson(x)));

String allStoryModelToJson(List<AllStoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllStoryModel {
    String userId;
    String imageUrl;
    String createdBy;
    List<StoryList> storyList;

    AllStoryModel({
        this.userId,
        this.imageUrl,
        this.createdBy,
        this.storyList,
    });

    factory AllStoryModel.fromJson(Map<String, dynamic> json) => AllStoryModel(
        userId: json["userId"] == null ? null : json["userId"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        storyList: json["storyList"] == null ? null : List<StoryList>.from(json["storyList"].map((x) => StoryList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "imageUrl": imageUrl == null ? null : imageUrl,
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
