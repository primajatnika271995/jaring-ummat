// To parse this JSON data, do
//
//     final aktivitasTerbesarModel = aktivitasTerbesarModelFromJson(jsonString);

import 'dart:convert';

List<AktivitasTerbesarModel> aktivitasTerbesarModelFromJson(String str) => List<AktivitasTerbesarModel>.from(json.decode(str).map((x) => AktivitasTerbesarModel.fromJson(x)));

String aktivitasTerbesarModelToJson(List<AktivitasTerbesarModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AktivitasTerbesarModel {
    String imageContent;
    String lembagaAmalId;
    String lembagaAmalName;
    int totalAmal;
    dynamic totalAktifitas;
    int requestedDate;
    String category;

    AktivitasTerbesarModel({
        this.imageContent,
        this.lembagaAmalId,
        this.lembagaAmalName,
        this.totalAmal,
        this.totalAktifitas,
        this.requestedDate,
        this.category,
    });

    factory AktivitasTerbesarModel.fromJson(Map<String, dynamic> json) => AktivitasTerbesarModel(
        imageContent: json["imageContent"] == null ? null : json["imageContent"],
        lembagaAmalId: json["lembagaAmalId"] == null ? null : json["lembagaAmalId"],
        lembagaAmalName: json["lembagaAmalName"] == null ? null : json["lembagaAmalName"],
        totalAmal: json["totalAmal"] == null ? null : json["totalAmal"],
        totalAktifitas: json["totalAktifitas"],
        requestedDate: json["requestedDate"] == null ? null : json["requestedDate"],
        category: json["category"] == null ? null : json["category"],
    );

    Map<String, dynamic> toJson() => {
        "imageContent": imageContent == null ? null : imageContent,
        "lembagaAmalId": lembagaAmalId == null ? null : lembagaAmalId,
        "lembagaAmalName": lembagaAmalName == null ? null : lembagaAmalName,
        "totalAmal": totalAmal == null ? null : totalAmal,
        "totalAktifitas": totalAktifitas,
        "requestedDate": requestedDate == null ? null : requestedDate,
        "category": category == null ? null : category,
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
