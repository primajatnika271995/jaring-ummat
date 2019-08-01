// To parse this JSON data, do
//
//     final programAmalModel = programAmalModelFromJson(jsonString);

import 'dart:convert';

List<ProgramAmalModel> programAmalModelFromJson(String str) => new List<ProgramAmalModel>.from(json.decode(str).map((x) => ProgramAmalModel.fromJson(x)));

String programAmalModelToJson(List<ProgramAmalModel> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class ProgramAmalModel {
    String id;
    String idUser;
    dynamic idUserLike;
    String titleProgram;
    String category;
    String endDonasi;
    double targetDonasi;
    double totalDonasi;
    String descriptionProgram;
    List<ImageContent> imageContent;
    int createdDate;
    String createdBy;
    int totalComment;
    int totalLikes;

    ProgramAmalModel({
        this.id,
        this.idUser,
        this.idUserLike,
        this.titleProgram,
        this.category,
        this.endDonasi,
        this.targetDonasi,
        this.totalDonasi,
        this.descriptionProgram,
        this.imageContent,
        this.createdDate,
        this.createdBy,
        this.totalComment,
        this.totalLikes,
    });

    factory ProgramAmalModel.fromJson(Map<String, dynamic> json) => new ProgramAmalModel(
        id: json["id"] == null ? null : json["id"],
        idUser: json["idUser"] == null ? null : json["idUser"],
        idUserLike: json["idUserLike"],
        titleProgram: json["titleProgram"] == null ? null : json["titleProgram"],
        category: json["category"] == null ? null : json["category"],
        endDonasi: json["endDonasi"] == null ? null : json["endDonasi"],
        targetDonasi: json["targetDonasi"] == null ? null : json["targetDonasi"],
        totalDonasi: json["totalDonasi"] == null ? null : json["totalDonasi"],
        descriptionProgram: json["descriptionProgram"] == null ? null : json["descriptionProgram"],
        imageContent: json["imageContent"] == null ? null : new List<ImageContent>.from(json["imageContent"].map((x) => ImageContent.fromJson(x))),
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        totalComment: json["total_comment"] == null ? null : json["total_comment"],
        totalLikes: json["total_likes"] == null ? null : json["total_likes"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "idUser": idUser == null ? null : idUser,
        "idUserLike": idUserLike,
        "titleProgram": titleProgram == null ? null : titleProgram,
        "category": category == null ? null : category,
        "endDonasi": endDonasi == null ? null : endDonasi,
        "targetDonasi": targetDonasi == null ? null : targetDonasi,
        "totalDonasi": totalDonasi == null ? null : totalDonasi,
        "descriptionProgram": descriptionProgram == null ? null : descriptionProgram,
        "imageContent": imageContent == null ? null : new List<dynamic>.from(imageContent.map((x) => x.toJson())),
        "createdDate": createdDate == null ? null : createdDate,
        "createdBy": createdBy == null ? null : createdBy,
        "total_comment": totalComment == null ? null : totalComment,
        "total_likes": totalLikes == null ? null : totalLikes,
    };
}

class ImageContent {
    String id;
    dynamic thumbnailUrl;
    dynamic videoUrl;
    String imgUrl;
    int createdDate;
    dynamic createdBy;

    ImageContent({
        this.id,
        this.thumbnailUrl,
        this.videoUrl,
        this.imgUrl,
        this.createdDate,
        this.createdBy,
    });

    factory ImageContent.fromJson(Map<String, dynamic> json) => new ImageContent(
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
