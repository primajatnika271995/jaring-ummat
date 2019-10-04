// To parse this JSON data, do
//
//     final accountChats = accountChatsFromJson(jsonString);

import 'dart:convert';

List<AccountChats> accountChatsFromJson(String str) => new List<AccountChats>.from(json.decode(str).map((x) => AccountChats.fromJson(x)));

String accountChatsToJson(List<AccountChats> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class AccountChats {
    String id;
    String username;
    String tipeUser;
    String email;
    String contents;

    AccountChats({
        this.id,
        this.username,
        this.tipeUser,
        this.email,
        this.contents,
    });

    factory AccountChats.fromJson(Map<String, dynamic> json) => new AccountChats(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        tipeUser: json["tipe_user"] == null ? null : json["tipe_user"],
        email: json["email"] == null ? null : json["email"],
        contents: json["contents"] == null ? null : json["contents"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "tipe_user": tipeUser == null ? null : tipeUser,
        "email": email == null ? null : email,
        "contents": contents == null ? null : contents,
    };
}

class Content {
    String id;
    String thumbnailUrl;
    String videoUrl;
    String imgUrl;
    int createdDate;
    dynamic createdBy;

    Content({
        this.id,
        this.thumbnailUrl,
        this.videoUrl,
        this.imgUrl,
        this.createdDate,
        this.createdBy,
    });

    factory Content.fromJson(Map<String, dynamic> json) => new Content(
        id: json["id"] == null ? null : json["id"],
        thumbnailUrl: json["thumbnailUrl"] == null ? null : json["thumbnailUrl"],
        videoUrl: json["videoUrl"] == null ? null : json["videoUrl"],
        imgUrl: json["imgUrl"] == null ? null : json["imgUrl"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        createdBy: json["createdBy"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,
        "videoUrl": videoUrl == null ? null : videoUrl,
        "imgUrl": imgUrl == null ? null : imgUrl,
        "createdDate": createdDate == null ? null : createdDate,
        "createdBy": createdBy,
    };
}
