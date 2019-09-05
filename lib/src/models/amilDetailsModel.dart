// To parse this JSON data, do
//
//     final amilDetailsModel = amilDetailsModelFromJson(jsonString);

import 'dart:convert';

AmilDetailsModel amilDetailsModelFromJson(String str) => AmilDetailsModel.fromJson(json.decode(str));

String amilDetailsModelToJson(AmilDetailsModel data) => json.encode(data.toJson());

class AmilDetailsModel {
    String id;
    String idLembaga;
    String namaLembaga;
    String categoryLembaga;
    String contactLembaga;
    String alamatLembaga;
    String emailLembaga;
    List<ImgProfile> imgProfile;

    AmilDetailsModel({
        this.id,
        this.idLembaga,
        this.namaLembaga,
        this.categoryLembaga,
        this.contactLembaga,
        this.alamatLembaga,
        this.emailLembaga,
        this.imgProfile,
    });

    factory AmilDetailsModel.fromJson(Map<String, dynamic> json) => new AmilDetailsModel(
        id: json["id"] == null ? null : json["id"],
        idLembaga: json["idLembaga"] == null ? null : json["idLembaga"],
        namaLembaga: json["namaLembaga"] == null ? null : json["namaLembaga"],
        categoryLembaga: json["categoryLembaga"] == null ? null : json["categoryLembaga"],
        contactLembaga: json["contactLembaga"] == null ? null : json["contactLembaga"],
        alamatLembaga: json["alamatLembaga"] == null ? null : json["alamatLembaga"],
        emailLembaga: json["emailLembaga"] == null ? null : json["emailLembaga"],
        imgProfile: json["imgProfile"] == null ? null : new List<ImgProfile>.from(json["imgProfile"].map((x) => ImgProfile.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "idLembaga": idLembaga == null ? null : idLembaga,
        "namaLembaga": namaLembaga == null ? null : namaLembaga,
        "categoryLembaga": categoryLembaga == null ? null : categoryLembaga,
        "contactLembaga": contactLembaga == null ? null : contactLembaga,
        "alamatLembaga": alamatLembaga == null ? null : alamatLembaga,
        "emailLembaga": emailLembaga == null ? null : emailLembaga,
        "imgProfile": imgProfile == null ? null : new List<dynamic>.from(imgProfile.map((x) => x.toJson())),
    };
}

class ImgProfile {
    String id;
    dynamic thumbnailUrl;
    dynamic videoUrl;
    String imgUrl;
    int createdDate;
    dynamic createdBy;

    ImgProfile({
        this.id,
        this.thumbnailUrl,
        this.videoUrl,
        this.imgUrl,
        this.createdDate,
        this.createdBy,
    });

    factory ImgProfile.fromJson(Map<String, dynamic> json) => new ImgProfile(
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
