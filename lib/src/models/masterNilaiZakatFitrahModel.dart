// To parse this JSON data, do
//
//     final masterNilaiZakatFitrahModel = masterNilaiZakatFitrahModelFromJson(jsonString);

import 'dart:convert';

MasterNilaiZakatFitrahModel masterNilaiZakatFitrahModelFromJson(String str) => MasterNilaiZakatFitrahModel.fromJson(json.decode(str));

String masterNilaiZakatFitrahModelToJson(MasterNilaiZakatFitrahModel data) => json.encode(data.toJson());

class MasterNilaiZakatFitrahModel {
    int liter;
    int kilogram;

    MasterNilaiZakatFitrahModel({
        this.liter,
        this.kilogram,
    });

    factory MasterNilaiZakatFitrahModel.fromJson(Map<String, dynamic> json) => MasterNilaiZakatFitrahModel(
        liter: json["liter"] == null ? null : json["liter"],
        kilogram: json["kilogram"] == null ? null : json["kilogram"],
    );

    Map<String, dynamic> toJson() => {
        "liter": liter == null ? null : liter,
        "kilogram": kilogram == null ? null : kilogram,
    };
}
