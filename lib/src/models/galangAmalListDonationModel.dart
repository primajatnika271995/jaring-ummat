// To parse this JSON data, do
//
//     final galangAmalListDonation = galangAmalListDonationFromJson(jsonString);

import 'dart:convert';

List<GalangAmalListDonation> galangAmalListDonationFromJson(String str) => new List<GalangAmalListDonation>.from(json.decode(str).map((x) => GalangAmalListDonation.fromJson(x)));

String galangAmalListDonationToJson(List<GalangAmalListDonation> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class GalangAmalListDonation {
    String virtualAccountRequestId;
    String transactionId;
    String virtualAccount;
    int nominalDonasi;
    String category;
    String programAmalId;
    String customerName;
    String customerPhone;
    String customerUsername;
    String customerEmail;
    int nominalDibayar;
    int donasiDate;
    String imgUrl;

    GalangAmalListDonation({
        this.virtualAccountRequestId,
        this.transactionId,
        this.virtualAccount,
        this.nominalDonasi,
        this.category,
        this.programAmalId,
        this.customerName,
        this.customerPhone,
        this.customerUsername,
        this.customerEmail,
        this.nominalDibayar,
        this.donasiDate,
        this.imgUrl,
    });

    factory GalangAmalListDonation.fromJson(Map<String, dynamic> json) => new GalangAmalListDonation(
        virtualAccountRequestId: json["virtualAccountRequestId"] == null ? null : json["virtualAccountRequestId"],
        transactionId: json["transactionId"] == null ? null : json["transactionId"],
        virtualAccount: json["virtualAccount"] == null ? null : json["virtualAccount"],
        nominalDonasi: json["nominalDonasi"] == null ? null : json["nominalDonasi"],
        category: json["category"] == null ? null : json["category"],
        programAmalId: json["programAmalId"] == null ? null : json["programAmalId"],
        customerName: json["customerName"] == null ? null : json["customerName"],
        customerPhone: json["customerPhone"] == null ? null : json["customerPhone"],
        customerUsername: json["customerUsername"] == null ? null : json["customerUsername"],
        customerEmail: json["customerEmail"] == null ? null : json["customerEmail"],
        nominalDibayar: json["nominalDibayar"] == null ? null : json["nominalDibayar"],
        donasiDate: json["donasiDate"] == null ? null : json["donasiDate"],
        imgUrl: json["imgUrl"] == null ? null : json["imgUrl"],
    );

    Map<String, dynamic> toJson() => {
        "virtualAccountRequestId": virtualAccountRequestId == null ? null : virtualAccountRequestId,
        "transactionId": transactionId == null ? null : transactionId,
        "virtualAccount": virtualAccount == null ? null : virtualAccount,
        "nominalDonasi": nominalDonasi == null ? null : nominalDonasi,
        "category": category == null ? null : category,
        "programAmalId": programAmalId == null ? null : programAmalId,
        "customerName": customerName == null ? null : customerName,
        "customerPhone": customerPhone == null ? null : customerPhone,
        "customerUsername": customerUsername == null ? null : customerUsername,
        "customerEmail": customerEmail == null ? null : customerEmail,
        "nominalDibayar": nominalDibayar == null ? null : nominalDibayar,
        "donasiDate": donasiDate == null ? null : donasiDate,
        "imgUrl": imgUrl == null ? null : imgUrl,
    };
}
