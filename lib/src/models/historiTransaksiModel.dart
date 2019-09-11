// To parse this JSON data, do
//
//     final historiTransaksiModel = historiTransaksiModelFromJson(jsonString);

import 'dart:convert';

List<HistoriTransaksiModel> historiTransaksiModelFromJson(String str) => List<HistoriTransaksiModel>.from(json.decode(str).map((x) => HistoriTransaksiModel.fromJson(x)));

String historiTransaksiModelToJson(List<HistoriTransaksiModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoriTransaksiModel {
    String idTransaksi;
    String jenisTransaksi;
    String donasiTitle;
    int jumlahTransaksi;
    int jumlahDibayar;
    int tanggalTransaksi;
    bool status;

    HistoriTransaksiModel({
        this.idTransaksi,
        this.jenisTransaksi,
        this.donasiTitle,
        this.jumlahTransaksi,
        this.jumlahDibayar,
        this.tanggalTransaksi,
        this.status,
    });

    factory HistoriTransaksiModel.fromJson(Map<String, dynamic> json) => HistoriTransaksiModel(
        idTransaksi: json["idTransaksi"],
        jenisTransaksi: json["jenisTransaksi"],
        donasiTitle: json["donasiTitle"] == null ? null : json["donasiTitle"],
        jumlahTransaksi: json["jumlahTransaksi"],
        jumlahDibayar: json["jumlahDibayar"],
        tanggalTransaksi: json["tanggalTransaksi"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "idTransaksi": idTransaksi,
        "jenisTransaksi": jenisTransaksi,
        "donasiTitle": donasiTitle == null ? null : donasiTitle,
        "jumlahTransaksi": jumlahTransaksi,
        "jumlahDibayar": jumlahDibayar,
        "tanggalTransaksi": tanggalTransaksi,
        "status": status,
    };
}
