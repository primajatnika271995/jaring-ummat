// To parse this JSON data, do
//
//     final amilDetailsModel = amilDetailsModelFromJson(jsonString);

import 'dart:convert';

AmilDetailsModel amilDetailsModelFromJson(String str) => AmilDetailsModel.fromJson(json.decode(str));

String amilDetailsModelToJson(AmilDetailsModel data) => json.encode(data.toJson());

class AmilDetailsModel {
    String id;
    String idLembaga;
    String namaLembaga;
    String categoryLembaga;
    String contactLembaga;
    String alamatLembaga;
    String emailLembaga;

    AmilDetailsModel({
        this.id,
        this.idLembaga,
        this.namaLembaga,
        this.categoryLembaga,
        this.contactLembaga,
        this.alamatLembaga,
        this.emailLembaga,
    });

    factory AmilDetailsModel.fromJson(Map<String, dynamic> json) => new AmilDetailsModel(
        id: json["id"] == null ? null : json["id"],
        idLembaga: json["idLembaga"] == null ? null : json["idLembaga"],
        namaLembaga: json["namaLembaga"] == null ? null : json["namaLembaga"],
        categoryLembaga: json["categoryLembaga"] == null ? null : json["categoryLembaga"],
        contactLembaga: json["contactLembaga"] == null ? null : json["contactLembaga"],
        alamatLembaga: json["alamatLembaga"] == null ? null : json["alamatLembaga"],
        emailLembaga: json["emailLembaga"] == null ? null : json["emailLembaga"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "idLembaga": idLembaga == null ? null : idLembaga,
        "namaLembaga": namaLembaga == null ? null : namaLembaga,
        "categoryLembaga": categoryLembaga == null ? null : categoryLembaga,
        "contactLembaga": contactLembaga == null ? null : contactLembaga,
        "alamatLembaga": alamatLembaga == null ? null : alamatLembaga,
        "emailLembaga": emailLembaga == null ? null : emailLembaga,
    };
}
