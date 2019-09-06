// To parse this JSON data, do
//
//     final requestVaModel = requestVaModelFromJson(jsonString);

import 'dart:convert';

RequestVaModel requestVaModelFromJson(String str) => RequestVaModel.fromJson(json.decode(str));

String requestVaModelToJson(RequestVaModel data) => json.encode(data.toJson());

class RequestVaModel {
    Data data;
    String status;

    RequestVaModel({
        this.data,
        this.status,
    });

    factory RequestVaModel.fromJson(Map<String, dynamic> json) => new RequestVaModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "status": status == null ? null : status,
    };
}

class Data {
    String id;
    String username;
    String virtualNumber;
    bool virtualAccountStatus;
    String transactionId;
    String transactionCategory;
    String transactionRef;
    double nominal;
    String customerName;
    String customerEmail;
    String customerPhone;
    dynamic createdDate;
    dynamic datetimeExpired;
    dynamic datetimeLastUpdated;
    dynamic datetimePayment;
    dynamic paymentAmount;
    dynamic description;

    Data({
        this.id,
        this.username,
        this.virtualNumber,
        this.virtualAccountStatus,
        this.transactionId,
        this.transactionCategory,
        this.transactionRef,
        this.nominal,
        this.customerName,
        this.customerEmail,
        this.customerPhone,
        this.createdDate,
        this.datetimeExpired,
        this.datetimeLastUpdated,
        this.datetimePayment,
        this.paymentAmount,
        this.description,
    });

    factory Data.fromJson(Map<String, dynamic> json) => new Data(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        virtualNumber: json["virtualNumber"] == null ? null : json["virtualNumber"],
        virtualAccountStatus: json["virtualAccountStatus"] == null ? null : json["virtualAccountStatus"],
        transactionId: json["transactionId"] == null ? null : json["transactionId"],
        transactionCategory: json["transactionCategory"] == null ? null : json["transactionCategory"],
        transactionRef: json["transactionRef"] == null ? null : json["transactionRef"],
        nominal: json["nominal"] == null ? null : json["nominal"],
        customerName: json["customerName"] == null ? null : json["customerName"],
        customerEmail: json["customerEmail"] == null ? null : json["customerEmail"],
        customerPhone: json["customerPhone"] == null ? null : json["customerPhone"],
        createdDate: json["createdDate"],
        datetimeExpired: json["datetimeExpired"],
        datetimeLastUpdated: json["datetimeLastUpdated"],
        datetimePayment: json["datetimePayment"],
        paymentAmount: json["paymentAmount"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "virtualNumber": virtualNumber == null ? null : virtualNumber,
        "virtualAccountStatus": virtualAccountStatus == null ? null : virtualAccountStatus,
        "transactionId": transactionId == null ? null : transactionId,
        "transactionCategory": transactionCategory == null ? null : transactionCategory,
        "transactionRef": transactionRef == null ? null : transactionRef,
        "nominal": nominal == null ? null : nominal,
        "customerName": customerName == null ? null : customerName,
        "customerEmail": customerEmail == null ? null : customerEmail,
        "customerPhone": customerPhone == null ? null : customerPhone,
        "createdDate": createdDate,
        "datetimeExpired": datetimeExpired,
        "datetimeLastUpdated": datetimeLastUpdated,
        "datetimePayment": datetimePayment,
        "paymentAmount": paymentAmount,
        "description": description,
    };
}
