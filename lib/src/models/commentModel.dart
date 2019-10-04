// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

List<Comment> commentFromJson(String str) => new List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
    String idUser;
    String fullname;
    String title;
    String komentar;
    int createdDate;
    String imageProfile;

    Comment({
        this.idUser,
        this.fullname,
        this.title,
        this.komentar,
        this.createdDate,
        this.imageProfile,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => new Comment(
        idUser: json["idUser"] == null ? null : json["idUser"],
        fullname: json["fullname"] == null ? null : json["fullname"],
        title: json["title"] == null ? null : json["title"],
        komentar: json["komentar"] == null ? null : json["komentar"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        imageProfile: json["imageProfile"] == null ? null : json["imageProfile"],
    );

    Map<String, dynamic> toJson() => {
        "idUser": idUser == null ? null : idUser,
        "fullname": fullname == null ? null : fullname,
        "title": title == null ? null : title,
        "komentar": komentar == null ? null : komentar,
        "createdDate": createdDate == null ? null : createdDate,
        "imageProfile": imageProfile == null ? null : imageProfile,
    };
}

class Content {
    String id;
    dynamic thumbnailUrl;
    dynamic videoUrl;
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
        id: json["id"] == null ? null : json["id"],
        thumbnailUrl: json["thumbnailUrl"],
        videoUrl: json["videoUrl"],
        imgUrl: json["imgUrl"] == null ? null : json["imgUrl"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        createdBy: json["createdBy"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "thumbnailUrl": thumbnailUrl,
        "videoUrl": videoUrl,
        "imgUrl": imgUrl == null ? null : imgUrl,
        "createdDate": createdDate == null ? null : createdDate,
        "createdBy": createdBy,
    };
}
