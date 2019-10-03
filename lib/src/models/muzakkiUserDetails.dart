// To parse this JSON data, do
//
//     final muzakkiUserDetails = muzakkiUserDetailsFromJson(jsonString);

import 'dart:convert';

MuzakkiUserDetails muzakkiUserDetailsFromJson(String str) =>
    MuzakkiUserDetails.fromJson(json.decode(str));

String muzakkiUserDetailsToJson(MuzakkiUserDetails data) =>
    json.encode(data.toJson());

class MuzakkiUserDetails {
  String userId;
  String email;
  String fullname;
  String contact;
  String alamat;
  String kotaTinggal;
  dynamic longitudeTinggal;
  dynamic latitudeTinggal;
  String kotaLahir;
  dynamic longitudeLahir;
  dynamic latitudeLahir;
  String lokasiAmal;
  dynamic kabupaten;
  dynamic provinsi;
  dynamic tanggalLahir;
  String tipeAkun;
  String imageUrl;

  MuzakkiUserDetails({
    this.userId,
    this.email,
    this.fullname,
    this.contact,
    this.alamat,
    this.kotaTinggal,
    this.longitudeTinggal,
    this.latitudeTinggal,
    this.kotaLahir,
    this.longitudeLahir,
    this.latitudeLahir,
    this.lokasiAmal,
    this.kabupaten,
    this.provinsi,
    this.tanggalLahir,
    this.tipeAkun,
    this.imageUrl,
  });

  factory MuzakkiUserDetails.fromJson(Map<String, dynamic> json) =>
      MuzakkiUserDetails(
        userId: json["userId"] == null ? null : json["userId"],
        email: json["email"] == null ? null : json["email"],
        fullname: json["fullname"] == null ? null : json["fullname"],
        contact: json["contact"] == null ? null : json["contact"],
        alamat: json["alamat"] == null ? null : json["alamat"],
        kotaTinggal: json["kotaTinggal"] == null ? null : json["kotaTinggal"],
        longitudeTinggal: json["longitudeTinggal"],
        latitudeTinggal: json["latitudeTinggal"],
        kotaLahir: json["kotaLahir"] == null ? null : json["kotaLahir"],
        longitudeLahir: json["longitudeLahir"],
        latitudeLahir: json["latitudeLahir"],
        lokasiAmal: json["lokasiAmal"] == null ? null : json["lokasiAmal"],
        tanggalLahir: json["tanggalLahir"],
        kabupaten: json["kabupaten"],
        provinsi: json["provinsi"],
        tipeAkun: json["tipeAkun"] == null ? null : json["tipeAkun"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "email": email == null ? null : email,
        "fullname": fullname == null ? null : fullname,
        "contact": contact == null ? null : contact,
        "alamat": alamat == null ? null : alamat,
        "kotaTinggal": kotaTinggal == null ? null : kotaTinggal,
        "longitudeTinggal": longitudeTinggal,
        "latitudeTinggal": latitudeTinggal,
        "kotaLahir": kotaLahir == null ? null : kotaLahir,
        "longitudeLahir": longitudeLahir,
        "latitudeLahir": latitudeLahir,
        "lokasiAmal": lokasiAmal == null ? null : lokasiAmal,
        "tanggalLahir": tanggalLahir,
        "kabupaten": kabupaten,
        "provinsi": provinsi,
        "tipeAkun": tipeAkun == null ? null : tipeAkun,
        "imageUrl": imageUrl == null ? null : imageUrl,
      };
}
