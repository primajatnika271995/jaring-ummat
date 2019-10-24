// To parse this JSON data, do
//
//     final fathimahBotJadwalSholatModel = fathimahBotJadwalSholatModelFromJson(jsonString);

import 'dart:convert';

FathimahBotJadwalSholatModel fathimahBotJadwalSholatModelFromJson(String str) => FathimahBotJadwalSholatModel.fromJson(json.decode(str));

String fathimahBotJadwalSholatModelToJson(FathimahBotJadwalSholatModel data) => json.encode(data.toJson());

class FathimahBotJadwalSholatModel {
  String status;
  Query query;
  Jadwal jadwal;

  FathimahBotJadwalSholatModel({
    this.status,
    this.query,
    this.jadwal,
  });

  factory FathimahBotJadwalSholatModel.fromJson(Map<String, dynamic> json) => FathimahBotJadwalSholatModel(
    status: json["status"] == null ? null : json["status"],
    query: json["query"] == null ? null : Query.fromJson(json["query"]),
    jadwal: json["jadwal"] == null ? null : Jadwal.fromJson(json["jadwal"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "query": query == null ? null : query.toJson(),
    "jadwal": jadwal == null ? null : jadwal.toJson(),
  };
}

class Jadwal {
  String status;
  Data data;

  Jadwal({
    this.status,
    this.data,
  });

  factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  String ashar;
  String dhuha;
  String dzuhur;
  String imsak;
  String isya;
  String maghrib;
  String subuh;
  String tanggal;
  String terbit;

  Data({
    this.ashar,
    this.dhuha,
    this.dzuhur,
    this.imsak,
    this.isya,
    this.maghrib,
    this.subuh,
    this.tanggal,
    this.terbit,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    ashar: json["ashar"] == null ? null : json["ashar"],
    dhuha: json["dhuha"] == null ? null : json["dhuha"],
    dzuhur: json["dzuhur"] == null ? null : json["dzuhur"],
    imsak: json["imsak"] == null ? null : json["imsak"],
    isya: json["isya"] == null ? null : json["isya"],
    maghrib: json["maghrib"] == null ? null : json["maghrib"],
    subuh: json["subuh"] == null ? null : json["subuh"],
    tanggal: json["tanggal"] == null ? null : json["tanggal"],
    terbit: json["terbit"] == null ? null : json["terbit"],
  );

  Map<String, dynamic> toJson() => {
    "ashar": ashar == null ? null : ashar,
    "dhuha": dhuha == null ? null : dhuha,
    "dzuhur": dzuhur == null ? null : dzuhur,
    "imsak": imsak == null ? null : imsak,
    "isya": isya == null ? null : isya,
    "maghrib": maghrib == null ? null : maghrib,
    "subuh": subuh == null ? null : subuh,
    "tanggal": tanggal == null ? null : tanggal,
    "terbit": terbit == null ? null : terbit,
  };
}

class Query {
  String format;
  String kota;
  DateTime tanggal;

  Query({
    this.format,
    this.kota,
    this.tanggal,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    format: json["format"] == null ? null : json["format"],
    kota: json["kota"] == null ? null : json["kota"],
    tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
  );

  Map<String, dynamic> toJson() => {
    "format": format == null ? null : format,
    "kota": kota == null ? null : kota,
    "tanggal": tanggal == null ? null : "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
  };
}
