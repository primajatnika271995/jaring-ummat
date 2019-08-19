// To parse this JSON data, do
//
//     final beritaModel = beritaModelFromJson(jsonString);

import 'dart:convert';

List<BeritaModel> beritaModelFromJson(String str) => new List<BeritaModel>.from(json.decode(str).map((x) => BeritaModel.fromJson(x)));

String beritaModelToJson(List<BeritaModel> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class BeritaModel {
    String idUser;
    String username;
    String idBerita;
    bool likeThis;
    String titleBerita;
    String descriptionBerita;
    String categoryBerita;
    dynamic imageContent;
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
    });

    factory BeritaModel.fromJson(Map<String, dynamic> json) => new BeritaModel(
        idUser: json["idUser"] == null ? null : json["idUser"],
        username: json["username"] == null ? null : json["username"],
        idBerita: json["idBerita"] == null ? null : json["idBerita"],
        likeThis: json["likeThis"] == null ? null : json["likeThis"],
        titleBerita: json["titleBerita"] == null ? null : json["titleBerita"],
        descriptionBerita: json["descriptionBerita"] == null ? null : json["descriptionBerita"],
        categoryBerita: json["categoryBerita"] == null ? null : json["categoryBerita"],
        imageContent: json["imageContent"],
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
        "titleBerita": titleBerita == null ? null : titleBerita,
        "descriptionBerita": descriptionBerita == null ? null : descriptionBerita,
        "categoryBerita": categoryBerita == null ? null : categoryBerita,
        "imageContent": imageContent,
        "createdDate": createdDate == null ? null : createdDate,
        "createdBy": createdBy == null ? null : createdBy,
        "totalLikes": totalLikes == null ? null : totalLikes,
        "totalComment": totalComment == null ? null : totalComment,
    };
}
