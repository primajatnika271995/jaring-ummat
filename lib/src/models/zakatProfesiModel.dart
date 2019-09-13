// To parse this JSON data, do
//
//     final zakatProfesiModel = zakatProfesiModelFromJson(jsonString);

import 'dart:convert';

ZakatProfesiModel zakatProfesiModelFromJson(String str) => ZakatProfesiModel.fromJson(json.decode(str));

String zakatProfesiModelToJson(ZakatProfesiModel data) => json.encode(data.toJson());

class ZakatProfesiModel {
    String jenisZakat;
    double jumlahZakat;

    ZakatProfesiModel({
        this.jenisZakat,
        this.jumlahZakat,
    });

    factory ZakatProfesiModel.fromJson(Map<String, dynamic> json) => ZakatProfesiModel(
        jenisZakat: json["jenisZakat"] == null ? null : json["jenisZakat"],
        jumlahZakat: json["jumlahZakat"] == null ? null : json["jumlahZakat"],
    );

    Map<String, dynamic> toJson() => {
        "jenisZakat": jenisZakat == null ? null : jenisZakat,
        "jumlahZakat": jumlahZakat == null ? null : jumlahZakat,
    };
}
