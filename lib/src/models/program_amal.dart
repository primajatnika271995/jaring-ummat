// To parse this JSON data, do
//
//     final programAmalModel = programAmalModelFromJson(jsonString);

import 'dart:convert';

List<ProgramAmalModel> programAmalModelFromJson(String str) => new List<ProgramAmalModel>.from(json.decode(str).map((x) => ProgramAmalModel.fromJson(x)));

String programAmalModelToJson(List<ProgramAmalModel> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class ProgramAmalModel {
    String idUser;
    String idProgram;
    String username;
    bool userLikeThis;
    String titleProgram;
    String descriptionProgram;
    String categoryProgram;
    double totalDonation;
    double targetDonation;
    String endDate;
    int totalLikes;
    int totalComments;
    List<ImageContent> imageContent;
    String createdBy;
    int createdDate;

    ProgramAmalModel({
        this.idUser,
        this.idProgram,
        this.username,
        this.userLikeThis,
        this.titleProgram,
        this.descriptionProgram,
        this.categoryProgram,
        this.totalDonation,
        this.targetDonation,
        this.endDate,
        this.totalLikes,
        this.totalComments,
        this.imageContent,
        this.createdBy,
        this.createdDate,
    });

    factory ProgramAmalModel.fromJson(Map<String, dynamic> json) => new ProgramAmalModel(
        idUser: json["idUser"] == null ? null : json["idUser"],
        idProgram: json["idProgram"] == null ? null : json["idProgram"],
        username: json["username"] == null ? null : json["username"],
        userLikeThis: json["userLikeThis"] == null ? null : json["userLikeThis"],
        titleProgram: json["titleProgram"] == null ? null : json["titleProgram"],
        descriptionProgram: json["descriptionProgram"] == null ? null : json["descriptionProgram"],
        categoryProgram: json["categoryProgram"] == null ? null : json["categoryProgram"],
        totalDonation: json["totalDonation"] == null ? null : json["totalDonation"],
        targetDonation: json["targetDonation"] == null ? null : json["targetDonation"],
        endDate: json["endDate"] == null ? null : json["endDate"],
        totalLikes: json["totalLikes"] == null ? null : json["totalLikes"],
        totalComments: json["totalComments"] == null ? null : json["totalComments"],
        imageContent: json["imageContent"] == null ? null : new List<ImageContent>.from(json["imageContent"].map((x) => ImageContent.fromJson(x))),
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
    );

    Map<String, dynamic> toJson() => {
        "idUser": idUser == null ? null : idUser,
        "idProgram": idProgram == null ? null : idProgram,
        "username": username == null ? null : username,
        "userLikeThis": userLikeThis == null ? null : userLikeThis,
        "titleProgram": titleProgram == null ? null : titleProgram,
        "descriptionProgram": descriptionProgram == null ? null : descriptionProgram,
        "categoryProgram": categoryProgram == null ? null : categoryProgram,
        "totalDonation": totalDonation == null ? null : totalDonation,
        "targetDonation": targetDonation == null ? null : targetDonation,
        "endDate": endDate == null ? null : endDate,
        "totalLikes": totalLikes == null ? null : totalLikes,
        "totalComments": totalComments == null ? null : totalComments,
        "imageContent": imageContent == null ? null : new List<dynamic>.from(imageContent.map((x) => x.toJson())),
        "createdBy": createdBy == null ? null : createdBy,
        "createdDate": createdDate == null ? null : createdDate,
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
