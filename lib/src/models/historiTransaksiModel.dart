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
    String virtualAccount;

    HistoriTransaksiModel({
        this.idTransaksi,
        this.jenisTransaksi,
        this.donasiTitle,
        this.jumlahTransaksi,
        this.jumlahDibayar,
        this.tanggalTransaksi,
        this.status,
        this.virtualAccount,
    });

    factory HistoriTransaksiModel.fromJson(Map<String, dynamic> json) => HistoriTransaksiModel(
        idTransaksi: json["idTransaksi"] == null ? null : json["idTransaksi"],
        jenisTransaksi: json["jenisTransaksi"] == null ? null : json["jenisTransaksi"],
        donasiTitle: json["donasiTitle"] == null ? null : json["donasiTitle"],
        jumlahTransaksi: json["jumlahTransaksi"] == null ? null : json["jumlahTransaksi"],
        jumlahDibayar: json["jumlahDibayar"],
        tanggalTransaksi: json["tanggalTransaksi"] == null ? null : json["tanggalTransaksi"],
        status: json["status"] == null ? null : json["status"],
        virtualAccount: json["virtualAccount"] == null ? null : json["virtualAccount"],
    );

    Map<String, dynamic> toJson() => {
        "idTransaksi": idTransaksi == null ? null : idTransaksi,
        "jenisTransaksi": jenisTransaksi == null ? null : jenisTransaksi,
        "donasiTitle": donasiTitle == null ? null : donasiTitle,
        "jumlahTransaksi": jumlahTransaksi == null ? null : jumlahTransaksi,
        "jumlahDibayar": jumlahDibayar,
        "tanggalTransaksi": tanggalTransaksi == null ? null : tanggalTransaksi,
        "status": status == null ? null : status,
        "virtualAccount": virtualAccount == null ? null : virtualAccount,
    };
}
