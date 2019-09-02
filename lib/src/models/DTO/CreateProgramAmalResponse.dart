// To parse this JSON data, do
//
//     final responseCreateProgramAmal = responseCreateProgramAmalFromJson(jsonString);

import 'dart:convert';

ResponseCreateProgramAmal responseCreateProgramAmalFromJson(String str) => ResponseCreateProgramAmal.fromJson(json.decode(str));

String responseCreateProgramAmalToJson(ResponseCreateProgramAmal data) => json.encode(data.toJson());

class ResponseCreateProgramAmal {
    String id;
    String idUser;
    String titleProgram;
    String category;
    String descriptionProgram;
    double totalDonasi;
    double targetDonasi;
    String endDonasi;
    int createdDate;
    String createdBy;

    ResponseCreateProgramAmal({
        this.id,
        this.idUser,
        this.titleProgram,
        this.category,
        this.descriptionProgram,
        this.totalDonasi,
        this.targetDonasi,
        this.endDonasi,
        this.createdDate,
        this.createdBy,
    });

    factory ResponseCreateProgramAmal.fromJson(Map<String, dynamic> json) => new ResponseCreateProgramAmal(
        id: json["id"] == null ? null : json["id"],
        idUser: json["idUser"] == null ? null : json["idUser"],
        titleProgram: json["titleProgram"] == null ? null : json["titleProgram"],
        category: json["category"] == null ? null : json["category"],
        descriptionProgram: json["descriptionProgram"] == null ? null : json["descriptionProgram"],
        totalDonasi: json["totalDonasi"] == null ? null : json["totalDonasi"],
        targetDonasi: json["targetDonasi"] == null ? null : json["targetDonasi"],
        endDonasi: json["endDonasi"] == null ? null : json["endDonasi"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "idUser": idUser == null ? null : idUser,
        "titleProgram": titleProgram == null ? null : titleProgram,
        "category": category == null ? null : category,
        "descriptionProgram": descriptionProgram == null ? null : descriptionProgram,
        "totalDonasi": totalDonasi == null ? null : totalDonasi,
        "targetDonasi": targetDonasi == null ? null : targetDonasi,
        "endDonasi": endDonasi == null ? null : endDonasi,
        "createdDate": createdDate == null ? null : createdDate,
        "createdBy": createdBy == null ? null : createdBy,
    };
}
