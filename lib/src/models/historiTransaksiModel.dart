// To parse this JSON data, do
//
//     final historiTransaksiModel = historiTransaksiModelFromJson(jsonString);

import 'dart:convert';

List<HistoriTransaksiModel> historiTransaksiModelFromJson(String str) => new List<HistoriTransaksiModel>.from(json.decode(str).map((x) => HistoriTransaksiModel.fromJson(x)));

String historiTransaksiModelToJson(List<HistoriTransaksiModel> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class HistoriTransaksiModel {
    String idTransaksi;
    JenisTransaksi jenisTransaksi;
    String donasiTitle;
    int jumlahTransaksi;
    int jumlahDibayar;
    int tanggalTransaksi;
    Status status;

    HistoriTransaksiModel({
        this.idTransaksi,
        this.jenisTransaksi,
        this.donasiTitle,
        this.jumlahTransaksi,
        this.jumlahDibayar,
        this.tanggalTransaksi,
        this.status,
    });

    factory HistoriTransaksiModel.fromJson(Map<String, dynamic> json) => new HistoriTransaksiModel(
        idTransaksi: json["idTransaksi"] == null ? null : json["idTransaksi"],
        jenisTransaksi: json["jenisTransaksi"] == null ? null : jenisTransaksiValues.map[json["jenisTransaksi"]],
        donasiTitle: json["donasiTitle"] == null ? null : json["donasiTitle"],
        jumlahTransaksi: json["jumlahTransaksi"] == null ? null : json["jumlahTransaksi"],
        jumlahDibayar: json["jumlahDibayar"] == null ? null : json["jumlahDibayar"],
        tanggalTransaksi: json["tanggalTransaksi"] == null ? null : json["tanggalTransaksi"],
        status: json["status"] == null ? null : statusValues.map[json["status"]],
    );

    Map<String, dynamic> toJson() => {
        "idTransaksi": idTransaksi == null ? null : idTransaksi,
        "jenisTransaksi": jenisTransaksi == null ? null : jenisTransaksiValues.reverse[jenisTransaksi],
        "donasiTitle": donasiTitle == null ? null : donasiTitle,
        "jumlahTransaksi": jumlahTransaksi == null ? null : jumlahTransaksi,
        "jumlahDibayar": jumlahDibayar == null ? null : jumlahDibayar,
        "tanggalTransaksi": tanggalTransaksi == null ? null : tanggalTransaksi,
        "status": status == null ? null : statusValues.reverse[status],
    };
}

enum JenisTransaksi { DONASI, WAKAF, INFAQ, ZAKAT, SODAQOH }

final jenisTransaksiValues = new EnumValues({
    "DONASI": JenisTransaksi.DONASI,
    "INFAQ": JenisTransaksi.INFAQ,
    "SODAQOH": JenisTransaksi.SODAQOH,
    "WAKAF": JenisTransaksi.WAKAF,
    "ZAKAT": JenisTransaksi.ZAKAT
});

enum Status { SUDAH_DI_BAYAR, BELUM_DI_BAYAR }

final statusValues = new EnumValues({
    "Belum Di Bayar": Status.BELUM_DI_BAYAR,
    "Sudah Di Bayar": Status.SUDAH_DI_BAYAR
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
