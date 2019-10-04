// To parse this JSON data, do
//
//     final aktivitasAmalTerbaruModel = aktivitasAmalTerbaruModelFromJson(jsonString);

import 'dart:convert';

List<AktivitasAmalTerbaruModel> aktivitasAmalTerbaruModelFromJson(String str) => List<AktivitasAmalTerbaruModel>.from(json.decode(str).map((x) => AktivitasAmalTerbaruModel.fromJson(x)));

String aktivitasAmalTerbaruModelToJson(List<AktivitasAmalTerbaruModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AktivitasAmalTerbaruModel {
    String imageContent;
    String username;
    String nama;
    int totalAmal;
    int totalAktifitas;

    AktivitasAmalTerbaruModel({
        this.imageContent,
        this.username,
        this.nama,
        this.totalAmal,
        this.totalAktifitas,
    });

    factory AktivitasAmalTerbaruModel.fromJson(Map<String, dynamic> json) => AktivitasAmalTerbaruModel(
        imageContent: json["imageContent"] == null ? null : json["imageContent"],
        username: json["username"] == null ? null : json["username"],
        nama: json["nama"] == null ? null : json["nama"],
        totalAmal: json["totalAmal"] == null ? null : json["totalAmal"],
        totalAktifitas: json["totalAktifitas"] == null ? null : json["totalAktifitas"],
    );

    Map<String, dynamic> toJson() => {
        "imageContent": imageContent == null ? null : imageContent,
        "username": username == null ? null : username,
        "nama": nama == null ? null : nama,
        "totalAmal": totalAmal == null ? null : totalAmal,
        "totalAktifitas": totalAktifitas == null ? null : totalAktifitas,
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
