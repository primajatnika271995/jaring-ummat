// To parse this JSON data, do
//
//     final penerimaanAmalTerbesarModel = penerimaanAmalTerbesarModelFromJson(jsonString);

import 'dart:convert';

List<PenerimaanAmalTerbesarModel> penerimaanAmalTerbesarModelFromJson(String str) => List<PenerimaanAmalTerbesarModel>.from(json.decode(str).map((x) => PenerimaanAmalTerbesarModel.fromJson(x)));

String penerimaanAmalTerbesarModelToJson(List<PenerimaanAmalTerbesarModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PenerimaanAmalTerbesarModel {
    dynamic imageContent;
    String username;
    String nama;
    int totalAmal;
    dynamic totalAktifitas;
    int requestedDate;
    String category;

    PenerimaanAmalTerbesarModel({
        this.imageContent,
        this.username,
        this.nama,
        this.totalAmal,
        this.totalAktifitas,
        this.requestedDate,
        this.category,
    });

    factory PenerimaanAmalTerbesarModel.fromJson(Map<String, dynamic> json) => PenerimaanAmalTerbesarModel(
        imageContent: json["imageContent"],
        username: json["username"] == null ? null : json["username"],
        nama: json["nama"] == null ? null : json["nama"],
        totalAmal: json["totalAmal"] == null ? null : json["totalAmal"],
        totalAktifitas: json["totalAktifitas"],
        requestedDate: json["requestedDate"] == null ? null : json["requestedDate"],
        category: json["category"] == null ? null : json["category"],
    );

    Map<String, dynamic> toJson() => {
        "imageContent": imageContent,
        "username": username == null ? null : username,
        "nama": nama == null ? null : nama,
        "totalAmal": totalAmal == null ? null : totalAmal,
        "totalAktifitas": totalAktifitas,
        "requestedDate": requestedDate == null ? null : requestedDate,
        "category": category == null ? null : category,
    };
}
