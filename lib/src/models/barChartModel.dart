// To parse this JSON data, do
//
//     final barchartModel = barchartModelFromJson(jsonString);

import 'dart:convert';

List<BarchartModel> barchartModelFromJson(String str) => List<BarchartModel>.from(json.decode(str).map((x) => BarchartModel.fromJson(x)));

String barchartModelToJson(List<BarchartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BarchartModel {
    int bulanAngka;
    String namaBulan;
    int total;

    BarchartModel({
        this.bulanAngka,
        this.namaBulan,
        this.total,
    });

    factory BarchartModel.fromJson(Map<String, dynamic> json) => BarchartModel(
        bulanAngka: json["bulanAngka"] == null ? null : json["bulanAngka"],
        namaBulan: json["namaBulan"] == null ? null : json["namaBulan"],
        total: json["total"] == null ? null : json["total"],
    );

    Map<String, dynamic> toJson() => {
        "bulanAngka": bulanAngka == null ? null : bulanAngka,
        "namaBulan": namaBulan == null ? null : namaBulan,
        "total": total == null ? null : total,
    };
}
