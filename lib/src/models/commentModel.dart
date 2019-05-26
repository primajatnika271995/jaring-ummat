// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

List<Comment> commentFromJson(String str) => new List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
    String idUser;
    String fullname;
    String title;
    String komentar;
    int createdDate;
    dynamic content;

    Comment({
        this.idUser,
        this.fullname,
        this.title,
        this.komentar,
        this.createdDate,
        this.content,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => new Comment(
        idUser: json["idUser"],
        fullname: json["fullname"],
        title: json["title"],
        komentar: json["komentar"],
        createdDate: json["createdDate"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "fullname": fullname,
        "title": title,
        "komentar": komentar,
        "createdDate": createdDate,
        "content": content,
    };
}
