// To parse this JSON data, do
//
//     final responseCreateBerita = responseCreateBeritaFromJson(jsonString);

import 'dart:convert';

ResponseCreateBerita responseCreateBeritaFromJson(String str) => ResponseCreateBerita.fromJson(json.decode(str));

String responseCreateBeritaToJson(ResponseCreateBerita data) => json.encode(data.toJson());

class ResponseCreateBerita {
    String id;
    String idUser;
    String category;
    String title;
    String description;
    int createdDate;
    String createdBy;

    ResponseCreateBerita({
        this.id,
        this.idUser,
        this.category,
        this.title,
        this.description,
        this.createdDate,
        this.createdBy,
    });

    factory ResponseCreateBerita.fromJson(Map<String, dynamic> json) => new ResponseCreateBerita(
        id: json["id"] == null ? null : json["id"],
        idUser: json["idUser"] == null ? null : json["idUser"],
        category: json["category"] == null ? null : json["category"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "idUser": idUser == null ? null : idUser,
        "category": category == null ? null : category,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "createdDate": createdDate == null ? null : createdDate,
        "createdBy": createdBy == null ? null : createdBy,
    };
}
