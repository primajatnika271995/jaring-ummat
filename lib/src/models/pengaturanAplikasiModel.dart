// To parse this JSON data, do
//
//     final pengaturanAplikasiModel = pengaturanAplikasiModelFromJson(jsonString);

import 'dart:convert';

PengaturanAplikasiModel pengaturanAplikasiModelFromJson(String str) => PengaturanAplikasiModel.fromJson(json.decode(str));

String pengaturanAplikasiModelToJson(PengaturanAplikasiModel data) => json.encode(data.toJson());

class PengaturanAplikasiModel {
  String id;
  String userId;
  bool aktivitasAmal;
  bool komentarGalangAmal;
  bool pengingatSholat;
  bool ayatAlquranHarian;
  bool aksiGalangAmal;
  bool beritaAmil;
  bool akunAmilBaru;
  bool chatDariAmil;
  bool portofolio;
  int createdDate;
  int modifyDate;

  PengaturanAplikasiModel({
    this.id,
    this.userId,
    this.aktivitasAmal,
    this.komentarGalangAmal,
    this.pengingatSholat,
    this.ayatAlquranHarian,
    this.aksiGalangAmal,
    this.beritaAmil,
    this.akunAmilBaru,
    this.chatDariAmil,
    this.portofolio,
    this.createdDate,
    this.modifyDate,
  });

  factory PengaturanAplikasiModel.fromJson(Map<String, dynamic> json) => PengaturanAplikasiModel(
    id: json["id"] == null ? null : json["id"],
    userId: json["userId"] == null ? null : json["userId"],
    aktivitasAmal: json["aktivitasAmal"] == null ? null : json["aktivitasAmal"],
    komentarGalangAmal: json["komentarGalangAmal"] == null ? null : json["komentarGalangAmal"],
    pengingatSholat: json["pengingatSholat"] == null ? null : json["pengingatSholat"],
    ayatAlquranHarian: json["ayatAlquranHarian"] == null ? null : json["ayatAlquranHarian"],
    aksiGalangAmal: json["aksiGalangAmal"] == null ? null : json["aksiGalangAmal"],
    beritaAmil: json["beritaAmil"] == null ? null : json["beritaAmil"],
    akunAmilBaru: json["akunAmilBaru"] == null ? null : json["akunAmilBaru"],
    chatDariAmil: json["chatDariAmil"] == null ? null : json["chatDariAmil"],
    portofolio: json["portofolio"] == null ? null : json["portofolio"],
    createdDate: json["createdDate"] == null ? null : json["createdDate"],
    modifyDate: json["modifyDate"] == null ? null : json["modifyDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userId": userId == null ? null : userId,
    "aktivitasAmal": aktivitasAmal == null ? null : aktivitasAmal,
    "komentarGalangAmal": komentarGalangAmal == null ? null : komentarGalangAmal,
    "pengingatSholat": pengingatSholat == null ? null : pengingatSholat,
    "ayatAlquranHarian": ayatAlquranHarian == null ? null : ayatAlquranHarian,
    "aksiGalangAmal": aksiGalangAmal == null ? null : aksiGalangAmal,
    "beritaAmil": beritaAmil == null ? null : beritaAmil,
    "akunAmilBaru": akunAmilBaru == null ? null : akunAmilBaru,
    "chatDariAmil": chatDariAmil == null ? null : chatDariAmil,
    "portofolio": portofolio == null ? null : portofolio,
    "createdDate": createdDate == null ? null : createdDate,
    "modifyDate": modifyDate == null ? null : modifyDate,
  };
}
