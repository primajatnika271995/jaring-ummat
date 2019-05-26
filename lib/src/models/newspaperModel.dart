// To parse this JSON data, do
//
//     final newspaper = newspaperFromJson(jsonString);

import 'dart:convert';

List<Newspaper> newspaperFromJson(String str) => new List<Newspaper>.from(json.decode(str).map((x) => Newspaper.fromJson(x)));

String newspaperToJson(List<Newspaper> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Newspaper {
    String id;
    String idUser;
    String imageProfile;
    String title;
    String description;
    List<String> imageContent;
    int createdDate;
    String createdBy;
    int totalKomentar;

    Newspaper({
        this.id,
        this.idUser,
        this.imageProfile,
        this.title,
        this.description,
        this.imageContent,
        this.createdDate,
        this.createdBy,
        this.totalKomentar,
    });

    factory Newspaper.fromJson(Map<String, dynamic> json) => new Newspaper(
        id: json["id"],
        idUser: json["idUser"],
        imageProfile: json["imageProfile"],
        title: json["title"],
        description: json["description"],
        imageContent: new List<String>.from(json["imageContent"].map((x) => x)),
        createdDate: json["createdDate"],
        createdBy: json["createdBy"],
        totalKomentar: json["total_komentar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idUser": idUser,
        "imageProfile": imageProfile,
        "title": title,
        "description": description,
        "imageContent": new List<dynamic>.from(imageContent.map((x) => x)),
        "createdDate": createdDate,
        "createdBy": createdBy,
        "total_komentar": totalKomentar,
    };
}
