// To parse this JSON data, do
//
//     final likes = likesFromJson(jsonString);

import 'dart:convert';

List<Likes> likesFromJson(String str) => new List<Likes>.from(json.decode(str).map((x) => Likes.fromJson(x)));

String likesToJson(List<Likes> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Likes {
    String id;
    String idUserLike;
    String idProgramLike;
    String idNewsLike;
    int createdDate;

    Likes({
        this.id,
        this.idUserLike,
        this.idProgramLike,
        this.idNewsLike,
        this.createdDate,
    });

    factory Likes.fromJson(Map<String, dynamic> json) => new Likes(
        id: json["id"] == null ? null : json["id"],
        idUserLike: json["idUserLike"] == null ? null : json["idUserLike"],
        idProgramLike: json["idProgramLike"] == null ? null : json["idProgramLike"],
        idNewsLike: json["idNewsLike"] == null ? null : json["idNewsLike"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "idUserLike": idUserLike == null ? null : idUserLike,
        "idProgramLike": idProgramLike == null ? null : idProgramLike,
        "idNewsLike": idNewsLike == null ? null : idNewsLike,
        "createdDate": createdDate == null ? null : createdDate,
    };
}
