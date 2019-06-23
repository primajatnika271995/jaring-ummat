// To parse this JSON data, do
//
//     final content = contentFromJson(jsonString);

import 'dart:convert';

List<Content> contentFromJson(String str) => new List<Content>.from(json.decode(str).map((x) => Content.fromJson(x)));

String contentToJson(List<Content> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Content {
    String id;
    int createdDate;
    List<ContentElement> contents;

    Content({
        this.id,
        this.createdDate,
        this.contents,
    });

    factory Content.fromJson(Map<String, dynamic> json) => new Content(
        id: json["id"],
        createdDate: json["createdDate"],
        contents: new List<ContentElement>.from(json["contents"].map((x) => ContentElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate,
        "contents": new List<dynamic>.from(contents.map((x) => x.toJson())),
    };
}

class ContentElement {
    String id;
    String thumbnailUrl;
    String videoUrl;
    String imgUrl;
    int createdDate;
    dynamic createdBy;

    ContentElement({
        this.id,
        this.thumbnailUrl,
        this.videoUrl,
        this.imgUrl,
        this.createdDate,
        this.createdBy,
    });

    factory ContentElement.fromJson(Map<String, dynamic> json) => new ContentElement(
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


