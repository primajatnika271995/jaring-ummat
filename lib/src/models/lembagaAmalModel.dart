// To parse this JSON data, do
//
//     final lembagaAmalModel = lembagaAmalModelFromJson(jsonString);

import 'dart:convert';

List<LembagaAmalModel> lembagaAmalModelFromJson(String str) => List<LembagaAmalModel>.from(json.decode(str).map((x) => LembagaAmalModel.fromJson(x)));

String lembagaAmalModelToJson(List<LembagaAmalModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LembagaAmalModel {
    String idUser;
    String idLembagaAmal;
    String lembagaAmalName;
    String lembagaAmalEmail;
    String lembagaAmalAddress;
    String lembagaAmalContact;
    String lembagaAmalCategory;
    String imageContent;
    int totalFollowers;
    int totalPostProgramAmal;
    int totalPostBerita;
    bool followThisAccount;
    String tipeAkun;

    LembagaAmalModel({
        this.idUser,
        this.idLembagaAmal,
        this.lembagaAmalName,
        this.lembagaAmalEmail,
        this.lembagaAmalAddress,
        this.lembagaAmalContact,
        this.lembagaAmalCategory,
        this.imageContent,
        this.totalFollowers,
        this.totalPostProgramAmal,
        this.totalPostBerita,
        this.followThisAccount,
        this.tipeAkun,
    });

    factory LembagaAmalModel.fromJson(Map<String, dynamic> json) => LembagaAmalModel(
        idUser: json["idUser"] == null ? null : json["idUser"],
        idLembagaAmal: json["idLembagaAmal"] == null ? null : json["idLembagaAmal"],
        lembagaAmalName: json["lembagaAmalName"] == null ? null : json["lembagaAmalName"],
        lembagaAmalEmail: json["lembagaAmalEmail"] == null ? null : json["lembagaAmalEmail"],
        lembagaAmalAddress: json["lembagaAmalAddress"] == null ? null : json["lembagaAmalAddress"],
        lembagaAmalContact: json["lembagaAmalContact"] == null ? null : json["lembagaAmalContact"],
        lembagaAmalCategory: json["lembagaAmalCategory"] == null ? null : json["lembagaAmalCategory"],
        imageContent: json["imageContent"] == null ? null : json["imageContent"],
        totalFollowers: json["totalFollowers"] == null ? null : json["totalFollowers"],
        totalPostProgramAmal: json["totalPostProgramAmal"] == null ? null : json["totalPostProgramAmal"],
        totalPostBerita: json["totalPostBerita"] == null ? null : json["totalPostBerita"],
        followThisAccount: json["followThisAccount"] == null ? null : json["followThisAccount"],
        tipeAkun: json["tipeAkun"] == null ? null : json["tipeAkun"],
    );

    Map<String, dynamic> toJson() => {
        "idUser": idUser == null ? null : idUser,
        "idLembagaAmal": idLembagaAmal == null ? null : idLembagaAmal,
        "lembagaAmalName": lembagaAmalName == null ? null : lembagaAmalName,
        "lembagaAmalEmail": lembagaAmalEmail == null ? null : lembagaAmalEmail,
        "lembagaAmalAddress": lembagaAmalAddress == null ? null : lembagaAmalAddress,
        "lembagaAmalContact": lembagaAmalContact == null ? null : lembagaAmalContact,
        "lembagaAmalCategory": lembagaAmalCategory == null ? null : lembagaAmalCategory,
        "imageContent": imageContent == null ? null : imageContent,
        "totalFollowers": totalFollowers == null ? null : totalFollowers,
        "totalPostProgramAmal": totalPostProgramAmal == null ? null : totalPostProgramAmal,
        "totalPostBerita": totalPostBerita == null ? null : totalPostBerita,
        "followThisAccount": followThisAccount == null ? null : followThisAccount,
        "tipeAkun": tipeAkun == null ? null : tipeAkun,
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

    factory ImageContent.fromJson(Map<String, dynamic> json) => ImageContent(
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
