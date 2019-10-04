// To parse this JSON data, do
//
//     final programAmalModel = programAmalModelFromJson(jsonString);

import 'dart:convert';

List<ProgramAmalModel> programAmalModelFromJson(String str) => List<ProgramAmalModel>.from(json.decode(str).map((x) => ProgramAmalModel.fromJson(x)));

String programAmalModelToJson(List<ProgramAmalModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProgramAmalModel {
    User user;
    String username;
    String idProgram;
    bool userLikeThis;
    String titleProgram;
    String descriptionProgram;
    String categoryProgram;
    dynamic totalDonation;
    dynamic targetDonation;
    DateTime endDate;
    int totalLikes;
    int totalComments;
    List<ImageContent> imageContent;
    String createdBy;
    int createdDate;
    bool btnKirimDonasi;

    ProgramAmalModel({
        this.user,
        this.username,
        this.idProgram,
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
        this.btnKirimDonasi,
    });

    factory ProgramAmalModel.fromJson(Map<String, dynamic> json) => ProgramAmalModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        username: json["username"] == null ? null : json["username"],
        idProgram: json["idProgram"] == null ? null : json["idProgram"],
        userLikeThis: json["userLikeThis"] == null ? null : json["userLikeThis"],
        titleProgram: json["titleProgram"] == null ? null : json["titleProgram"],
        descriptionProgram: json["descriptionProgram"] == null ? null : json["descriptionProgram"],
        categoryProgram: json["categoryProgram"] == null ? null : json["categoryProgram"],
        totalDonation: json["totalDonation"] == null ? null : json["totalDonation"],
        targetDonation: json["targetDonation"] == null ? null : json["targetDonation"],
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        totalLikes: json["totalLikes"] == null ? null : json["totalLikes"],
        totalComments: json["totalComments"] == null ? null : json["totalComments"],
        imageContent: json["imageContent"] == null ? null : List<ImageContent>.from(json["imageContent"].map((x) => ImageContent.fromJson(x))),
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        btnKirimDonasi: json["btnKirimDonasi"] == null ? null : json["btnKirimDonasi"],
    );

    Map<String, dynamic> toJson() => {
        "user": user == null ? null : user.toJson(),
        "username": username == null ? null : username,
        "idProgram": idProgram == null ? null : idProgram,
        "userLikeThis": userLikeThis == null ? null : userLikeThis,
        "titleProgram": titleProgram == null ? null : titleProgram,
        "descriptionProgram": descriptionProgram == null ? null : descriptionProgram,
        "categoryProgram": categoryProgram == null ? null : categoryProgram,
        "totalDonation": totalDonation == null ? null : totalDonation,
        "targetDonation": targetDonation == null ? null : targetDonation,
        "endDate": endDate == null ? null : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "totalLikes": totalLikes == null ? null : totalLikes,
        "totalComments": totalComments == null ? null : totalComments,
        "imageContent": imageContent == null ? null : List<dynamic>.from(imageContent.map((x) => x.toJson())),
        "createdBy": createdBy == null ? null : createdBy,
        "createdDate": createdDate == null ? null : createdDate,
        "btnKirimDonasi": btnKirimDonasi == null ? null : btnKirimDonasi,
    };
}

List<ImageContent> imageContentModelFromJson(String str) => List<ImageContent>.from(json.decode(str).map((x) => ImageContent.fromJson(x)));

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

class User {
    String userId;
    String email;
    String fullname;
    String contact;
    String alamat;
    String kotaTinggal;
    dynamic longitudeTinggal;
    dynamic latitudeTinggal;
    String kotaLahir;
    dynamic longitudeLahir;
    dynamic latitudeLahir;
    String lokasiAmal;
    dynamic tanggalLahir;
    String tipeAkun;
    dynamic imageUrl;

    User({
        this.userId,
        this.email,
        this.fullname,
        this.contact,
        this.alamat,
        this.kotaTinggal,
        this.longitudeTinggal,
        this.latitudeTinggal,
        this.kotaLahir,
        this.longitudeLahir,
        this.latitudeLahir,
        this.lokasiAmal,
        this.tanggalLahir,
        this.tipeAkun,
        this.imageUrl,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"] == null ? null : json["userId"],
        email: json["email"] == null ? null : json["email"],
        fullname: json["fullname"] == null ? null : json["fullname"],
        contact: json["contact"] == null ? null : json["contact"],
        alamat: json["alamat"] == null ? null : json["alamat"],
        kotaTinggal: json["kotaTinggal"] == null ? null : json["kotaTinggal"],
        longitudeTinggal: json["longitudeTinggal"],
        latitudeTinggal: json["latitudeTinggal"],
        kotaLahir: json["kotaLahir"] == null ? null : json["kotaLahir"],
        longitudeLahir: json["longitudeLahir"],
        latitudeLahir: json["latitudeLahir"],
        lokasiAmal: json["lokasiAmal"] == null ? null : json["lokasiAmal"],
        tanggalLahir: json["tanggalLahir"],
        tipeAkun: json["tipeAkun"] == null ? null : json["tipeAkun"],
        imageUrl: json["imageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "email": email == null ? null : email,
        "fullname": fullname == null ? null : fullname,
        "contact": contact == null ? null : contact,
        "alamat": alamat == null ? null : alamat,
        "kotaTinggal": kotaTinggal == null ? null : kotaTinggal,
        "longitudeTinggal": longitudeTinggal,
        "latitudeTinggal": latitudeTinggal,
        "kotaLahir": kotaLahir == null ? null : kotaLahir,
        "longitudeLahir": longitudeLahir,
        "latitudeLahir": latitudeLahir,
        "lokasiAmal": lokasiAmal == null ? null : lokasiAmal,
        "tanggalLahir": tanggalLahir,
        "tipeAkun": tipeAkun == null ? null : tipeAkun,
        "imageUrl": imageUrl,
    };
}
