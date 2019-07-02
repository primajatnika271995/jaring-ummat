// To parse this JSON data, do
//
//     final listUserLikes = listUserLikesFromJson(jsonString);

import 'dart:convert';

List<ListUserLikes> listUserLikesFromJson(String str) => new List<ListUserLikes>.from(json.decode(str).map((x) => ListUserLikes.fromJson(x)));

String listUserLikesToJson(List<ListUserLikes> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class ListUserLikes {
    String idUser;
    List<ImageProfile> imageProfile;

    ListUserLikes({
        this.idUser,
        this.imageProfile,
    });

    factory ListUserLikes.fromJson(Map<String, dynamic> json) => new ListUserLikes(
        idUser: json["idUser"] == null ? null : json["idUser"],
        imageProfile: json["imageProfile"] == null ? null : new List<ImageProfile>.from(json["imageProfile"].map((x) => ImageProfile.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idUser": idUser == null ? null : idUser,
        "imageProfile": imageProfile == null ? null : new List<dynamic>.from(imageProfile.map((x) => x.toJson())),
    };
}

class ImageProfile {
    String id;
    dynamic thumbnailUrl;
    dynamic videoUrl;
    String imgUrl;
    int createdDate;
    dynamic createdBy;

    ImageProfile({
        this.id,
        this.thumbnailUrl,
        this.videoUrl,
        this.imgUrl,
        this.createdDate,
        this.createdBy,
    });

    factory ImageProfile.fromJson(Map<String, dynamic> json) => new ImageProfile(
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
