// To parse this JSON data, do
//
//     final story = storyFromJson(jsonString);

import 'dart:convert';

List<Story> storyFromJson(String str) => new List<Story>.from(json.decode(str).map((x) => Story.fromJson(x)));

String storyToJson(List<Story> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Story {
    String userId;
    String createdBy;
    List<StoryList> storyList;

    Story({
        this.userId,
        this.createdBy,
        this.storyList,
    });

    factory Story.fromJson(Map<String, dynamic> json) => new Story(
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
    dynamic imgUrl;
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
