// To parse this JSON data, do
//
//     final lembagaAmal = lembagaAmalFromJson(jsonString);

import 'dart:convert';

List<LembagaAmal> lembagaAmalFromJson(String str) => new List<LembagaAmal>.from(json.decode(str).map((x) => LembagaAmal.fromJson(x)));

String lembagaAmalToJson(List<LembagaAmal> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class LembagaAmal {
    String id;
    dynamic idFollowerLogin;
    String namaLembaga;
    String emailLembaga;
    String categoryLembaga;
    String alamatLembaga;
    String contactLembaga;
    int createdDate;
    String totalFollow;
    String totalPost;
    List<ImageContent> imageContent;

    LembagaAmal({
        this.id,
        this.idFollowerLogin,
        this.namaLembaga,
        this.emailLembaga,
        this.categoryLembaga,
        this.alamatLembaga,
        this.contactLembaga,
        this.createdDate,
        this.totalFollow,
        this.totalPost,
        this.imageContent,
    });

    factory LembagaAmal.fromJson(Map<String, dynamic> json) => new LembagaAmal(
        id: json["id"] == null ? null : json["id"],
        idFollowerLogin: json["idFollowerLogin"],
        namaLembaga: json["namaLembaga"] == null ? null : json["namaLembaga"],
        emailLembaga: json["emailLembaga"] == null ? null : json["emailLembaga"],
        categoryLembaga: json["categoryLembaga"] == null ? null : json["categoryLembaga"],
        alamatLembaga: json["alamatLembaga"] == null ? null : json["alamatLembaga"],
        contactLembaga: json["contactLembaga"] == null ? null : json["contactLembaga"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        totalFollow: json["totalFollow"] == null ? null : json["totalFollow"],
        totalPost: json["totalPost"] == null ? null : json["totalPost"],
        imageContent: json["imageContent"] == null ? null : new List<ImageContent>.from(json["imageContent"].map((x) => ImageContent.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "idFollowerLogin": idFollowerLogin,
        "namaLembaga": namaLembaga == null ? null : namaLembaga,
        "emailLembaga": emailLembaga == null ? null : emailLembaga,
        "categoryLembaga": categoryLembaga == null ? null : categoryLembaga,
        "alamatLembaga": alamatLembaga == null ? null : alamatLembaga,
        "contactLembaga": contactLembaga == null ? null : contactLembaga,
        "createdDate": createdDate == null ? null : createdDate,
        "totalFollow": totalFollow == null ? null : totalFollow,
        "totalPost": totalPost == null ? null : totalPost,
        "imageContent": imageContent == null ? null : new List<dynamic>.from(imageContent.map((x) => x.toJson())),
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
