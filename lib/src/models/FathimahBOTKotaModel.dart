// To parse this JSON data, do
//
//     final fathimahBotKotaModel = fathimahBotKotaModelFromJson(jsonString);

import 'dart:convert';

FathimahBotKotaModel fathimahBotKotaModelFromJson(String str) => FathimahBotKotaModel.fromJson(json.decode(str));

String fathimahBotKotaModelToJson(FathimahBotKotaModel data) => json.encode(data.toJson());

class FathimahBotKotaModel {
  String status;
  Query query;
  List<Kota> kota;

  FathimahBotKotaModel({
    this.status,
    this.query,
    this.kota,
  });

  factory FathimahBotKotaModel.fromJson(Map<String, dynamic> json) => FathimahBotKotaModel(
    status: json["status"] == null ? null : json["status"],
    query: json["query"] == null ? null : Query.fromJson(json["query"]),
    kota: json["kota"] == null ? null : List<Kota>.from(json["kota"].map((x) => Kota.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "query": query == null ? null : query.toJson(),
    "kota": kota == null ? null : List<dynamic>.from(kota.map((x) => x.toJson())),
  };
}

class Kota {
  String id;
  String nama;

  Kota({
    this.id,
    this.nama,
  });

  factory Kota.fromJson(Map<String, dynamic> json) => Kota(
    id: json["id"] == null ? null : json["id"],
    nama: json["nama"] == null ? null : json["nama"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "nama": nama == null ? null : nama,
  };
}

class Query {
  String format;
  String nama;

  Query({
    this.format,
    this.nama,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    format: json["format"] == null ? null : json["format"],
    nama: json["nama"] == null ? null : json["nama"],
  );

  Map<String, dynamic> toJson() => {
    "format": format == null ? null : format,
    "nama": nama == null ? null : nama,
  };
}
