// To parse this JSON data, do
//
//     final beritaModel = beritaModelFromJson(jsonString);

import 'dart:convert';

List<BeritaModel> beritaModelFromJson(String str) => List<BeritaModel>.from(json.decode(str).map((x) => BeritaModel.fromJson(x)));

String beritaModelToJson(List<BeritaModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BeritaModel {
    String idUser;
    String username;
    String idBerita;
    bool likeThis;
    bool bookmarkThis;
    String titleBerita;
    String descriptionBerita;
    String categoryBerita;
    List<ImageContent> imageContent;
    int createdDate;
    String createdBy;
    int totalLikes;
    int totalComment;

    BeritaModel({
        this.idUser,
        this.username,
        this.idBerita,
        this.likeThis,
        this.titleBerita,
        this.descriptionBerita,
        this.categoryBerita,
        this.imageContent,
        this.createdDate,
        this.createdBy,
        this.totalLikes,
        this.totalComment,
        this.bookmarkThis,
    });

    factory BeritaModel.fromJson(Map<String, dynamic> json) => BeritaModel(
        idUser: json["idUser"] == null ? null : json["idUser"],
        username: json["username"] == null ? null : json["username"],
        idBerita: json["idBerita"] == null ? null : json["idBerita"],
        likeThis: json["likeThis"] == null ? null : json["likeThis"],
        bookmarkThis: json["bookmarkThis"] == null ? null : json["bookmarkThis"],
        titleBerita: json["titleBerita"] == null ? null : json["titleBerita"],
        descriptionBerita: json["descriptionBerita"] == null ? null : json["descriptionBerita"],
        categoryBerita: json["categoryBerita"] == null ? null : json["categoryBerita"],
        imageContent: json["imageContent"] == null ? null : List<ImageContent>.from(json["imageContent"].map((x) => ImageContent.fromJson(x))),
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        totalLikes: json["totalLikes"] == null ? null : json["totalLikes"],
        totalComment: json["totalComment"] == null ? null : json["totalComment"],
    );

    Map<String, dynamic> toJson() => {
        "idUser": idUser == null ? null : idUser,
        "username": username == null ? null : username,
        "idBerita": idBerita == null ? null : idBerita,
        "likeThis": likeThis == null ? null : likeThis,
        "bookmarkThis": bookmarkThis == null ? null : bookmarkThis,
        "titleBerita": titleBerita == null ? null : titleBerita,
        "descriptionBerita": descriptionBerita == null ? null : descriptionBerita,
        "categoryBerita": categoryBerita == null ? null : categoryBerita,
        "imageContent": imageContent == null ? null : List<dynamic>.from(imageContent.map((x) => x.toJson())),
        "createdDate": createdDate == null ? null : createdDate,
        "createdBy": createdBy == null ? null : createdBy,
        "totalLikes": totalLikes == null ? null : totalLikes,
        "totalComment": totalComment == null ? null : totalComment,
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
        this.formatFile
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
