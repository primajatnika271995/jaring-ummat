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
    String namaLembagaAmal;
    int jumlahTransaksi;
    int jumlahDibayar;
    int tanggalTransaksi;
    bool status;
    String virtualAccount;
    int totalMenitCounting;
    int tanggalBerakhirVa;

    HistoriTransaksiModel({
        this.idTransaksi,
        this.jenisTransaksi,
        this.donasiTitle,
        this.namaLembagaAmal,
        this.jumlahTransaksi,
        this.jumlahDibayar,
        this.tanggalTransaksi,
        this.status,
        this.virtualAccount,
        this.totalMenitCounting,
        this.tanggalBerakhirVa,
    });

    factory HistoriTransaksiModel.fromJson(Map<String, dynamic> json) => HistoriTransaksiModel(
        idTransaksi: json["idTransaksi"] == null ? null : json["idTransaksi"],
        jenisTransaksi: json["jenisTransaksi"] == null ? null : json["jenisTransaksi"],
        donasiTitle: json["donasiTitle"] == null ? null : json["donasiTitle"],
        namaLembagaAmal: json["namaLembagaAmal"] == null ? null : json["namaLembagaAmal"],
        jumlahTransaksi: json["jumlahTransaksi"] == null ? null : json["jumlahTransaksi"],
        jumlahDibayar: json["jumlahDibayar"],
        tanggalTransaksi: json["tanggalTransaksi"] == null ? null : json["tanggalTransaksi"],
        status: json["status"] == null ? null : json["status"],
        virtualAccount: json["virtualAccount"] == null ? null : json["virtualAccount"],
        totalMenitCounting: json["totalMenitCounting"] == null ? null : json["totalMenitCounting"],
        tanggalBerakhirVa: json["tanggalBerakhirVa"] == null ? null : json["tanggalBerakhirVa"],
    );

    Map<String, dynamic> toJson() => {
        "idTransaksi": idTransaksi == null ? null : idTransaksi,
        "jenisTransaksi": jenisTransaksi == null ? null : jenisTransaksi,
        "donasiTitle": donasiTitle == null ? null : donasiTitle,
        "namaLembagaAmal": namaLembagaAmal == null ? null : namaLembagaAmal,
        "jumlahTransaksi": jumlahTransaksi == null ? null : jumlahTransaksi,
        "jumlahDibayar": jumlahDibayar,
        "tanggalTransaksi": tanggalTransaksi == null ? null : tanggalTransaksi,
        "status": status == null ? null : status,
        "virtualAccount": virtualAccount == null ? null : virtualAccount,
        "totalMenitCounting": totalMenitCounting == null ? null : totalMenitCounting,
        "tanggalBerakhirVa": tanggalBerakhirVa == null ? null : tanggalBerakhirVa,
    };
}
