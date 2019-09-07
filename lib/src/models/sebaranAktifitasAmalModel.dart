// To parse this JSON data, do
//
//     final sebaranAktifitasAmalModel = sebaranAktifitasAmalModelFromJson(jsonString);

import 'dart:convert';

SebaranAktifitasAmalModel sebaranAktifitasAmalModelFromJson(String str) => SebaranAktifitasAmalModel.fromJson(json.decode(str));

String sebaranAktifitasAmalModelToJson(SebaranAktifitasAmalModel data) => json.encode(data.toJson());

class SebaranAktifitasAmalModel {
    dynamic totalSodaqohPercent;
    dynamic totalSemuaPercent;
    int totalZakat;
    int totalInfaq;
    int totalSodaqoh;
    dynamic totalWakafPercent;
    int totalSemua;
    dynamic totalDonasiPercent;
    int totalWakaf;
    dynamic totalZakatPercent;
    dynamic totalInfaqPercent;
    int totalDonasi;

    SebaranAktifitasAmalModel({
        this.totalSodaqohPercent,
        this.totalSemuaPercent,
        this.totalZakat,
        this.totalInfaq,
        this.totalSodaqoh,
        this.totalWakafPercent,
        this.totalSemua,
        this.totalDonasiPercent,
        this.totalWakaf,
        this.totalZakatPercent,
        this.totalInfaqPercent,
        this.totalDonasi,
    });

    factory SebaranAktifitasAmalModel.fromJson(Map<String, dynamic> json) => new SebaranAktifitasAmalModel(
        totalSodaqohPercent: json["totalSodaqohPercent"] == null ? null : json["totalSodaqohPercent"].toDouble(),
        totalSemuaPercent: json["totalSemuaPercent"] == null ? null : json["totalSemuaPercent"],
        totalZakat: json["totalZakat"] == null ? null : json["totalZakat"],
        totalInfaq: json["totalInfaq"] == null ? null : json["totalInfaq"],
        totalSodaqoh: json["totalSodaqoh"] == null ? null : json["totalSodaqoh"],
        totalWakafPercent: json["totalWakafPercent"] == null ? null : json["totalWakafPercent"],
        totalSemua: json["totalSemua"] == null ? null : json["totalSemua"],
        totalDonasiPercent: json["totalDonasiPercent"] == null ? null : json["totalDonasiPercent"].toDouble(),
        totalWakaf: json["totalWakaf"] == null ? null : json["totalWakaf"],
        totalZakatPercent: json["totalZakatPercent"] == null ? null : json["totalZakatPercent"].toDouble(),
        totalInfaqPercent: json["totalInfaqPercent"] == null ? null : json["totalInfaqPercent"].toDouble(),
        totalDonasi: json["totalDonasi"] == null ? null : json["totalDonasi"],
    );

    Map<String, dynamic> toJson() => {
        "totalSodaqohPercent": totalSodaqohPercent == null ? null : totalSodaqohPercent,
        "totalSemuaPercent": totalSemuaPercent == null ? null : totalSemuaPercent,
        "totalZakat": totalZakat == null ? null : totalZakat,
        "totalInfaq": totalInfaq == null ? null : totalInfaq,
        "totalSodaqoh": totalSodaqoh == null ? null : totalSodaqoh,
        "totalWakafPercent": totalWakafPercent == null ? null : totalWakafPercent,
        "totalSemua": totalSemua == null ? null : totalSemua,
        "totalDonasiPercent": totalDonasiPercent == null ? null : totalDonasiPercent,
        "totalWakaf": totalWakaf == null ? null : totalWakaf,
        "totalZakatPercent": totalZakatPercent == null ? null : totalZakatPercent,
        "totalInfaqPercent": totalInfaqPercent == null ? null : totalInfaqPercent,
        "totalDonasi": totalDonasi == null ? null : totalDonasi,
    };
}
