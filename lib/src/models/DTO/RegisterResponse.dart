// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
    String id;
    String username;
    String fullname;
    String tipeUser;
    String password;
    String email;
    String contact;
    int createdDate;

    RegisterResponseModel({
        this.id,
        this.username,
        this.fullname,
        this.tipeUser,
        this.password,
        this.email,
        this.contact,
        this.createdDate,
    });

    factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => new RegisterResponseModel(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        fullname: json["fullname"] == null ? null : json["fullname"],
        tipeUser: json["tipe_user"] == null ? null : json["tipe_user"],
        password: json["password"] == null ? null : json["password"],
        email: json["email"] == null ? null : json["email"],
        contact: json["contact"] == null ? null : json["contact"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "fullname": fullname == null ? null : fullname,
        "tipe_user": tipeUser == null ? null : tipeUser,
        "password": password == null ? null : password,
        "email": email == null ? null : email,
        "contact": contact == null ? null : contact,
        "createdDate": createdDate == null ? null : createdDate,
    };
}
