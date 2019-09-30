// To parse this JSON data, do
//
//     final filePathResponseModel = filePathResponseModelFromJson(jsonString);

import 'dart:convert';

FilePathResponseModel filePathResponseModelFromJson(String str) => FilePathResponseModel.fromJson(json.decode(str));

String filePathResponseModelToJson(FilePathResponseModel data) => json.encode(data.toJson());

class FilePathResponseModel {
    String id;
    String idUser;
    String resourceType;
    String urlType;
    String url;
    int createdDate;

    FilePathResponseModel({
        this.id,
        this.idUser,
        this.resourceType,
        this.urlType,
        this.url,
        this.createdDate,
    });

    factory FilePathResponseModel.fromJson(Map<String, dynamic> json) => FilePathResponseModel(
        id: json["id"] == null ? null : json["id"],
        idUser: json["id_user"] == null ? null : json["id_user"],
        resourceType: json["resource_type"] == null ? null : json["resource_type"],
        urlType: json["url_type"] == null ? null : json["url_type"],
        url: json["url"] == null ? null : json["url"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "id_user": idUser == null ? null : idUser,
        "resource_type": resourceType == null ? null : resourceType,
        "url_type": urlType == null ? null : urlType,
        "url": url == null ? null : url,
        "createdDate": createdDate == null ? null : createdDate,
    };
}
