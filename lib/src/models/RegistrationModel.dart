// To parse this JSON data, do
//
//     final registation = registationFromJson(jsonString);

import 'dart:convert';

Registation registationFromJson(String str) => Registation.fromJson(json.decode(str));

String registationToJson(Registation data) => json.encode(data.toJson());

class Registation {
  String id;
  String username;
  String fullname;
  String tipeUser;
  String password;
  String email;
  String contact;
  int createdDate;

  Registation({
    this.id,
    this.username,
    this.fullname,
    this.tipeUser,
    this.password,
    this.email,
    this.contact,
    this.createdDate,
  });

  factory Registation.fromJson(Map<String, dynamic> json) => new Registation(
    id: json["id"],
    username: json["username"],
    fullname: json["fullname"],
    tipeUser: json["tipe_user"],
    password: json["password"],
    email: json["email"],
    contact: json["contact"],
    createdDate: json["createdDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "fullname": fullname,
    "tipe_user": tipeUser,
    "password": password,
    "email": email,
    "contact": contact,
    "createdDate": createdDate,
  };
}
