// To parse this JSON data, do
//
//     final lineChartModel = lineChartModelFromJson(jsonString);

import 'dart:convert';

List<LineChartModel> lineChartModelFromJson(String str) => List<LineChartModel>.from(json.decode(str).map((x) => LineChartModel.fromJson(x)));

String lineChartModelToJson(List<LineChartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LineChartModel {
    String virtualAccountRequestId;
    String transactionId;
    String virtualAccount;
    int nominalDonasi;
    Category category;
    dynamic programAmalId;
    String customerName;
    String customerPhone;
    String customerUsername;
    String customerEmail;
    int nominalDibayar;
    String donasiDate;

    LineChartModel({
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
    });

    factory LineChartModel.fromJson(Map<String, dynamic> json) => LineChartModel(
        virtualAccountRequestId: json["virtualAccountRequestId"] == null ? null : json["virtualAccountRequestId"],
        transactionId: json["transactionId"] == null ? null : json["transactionId"],
        virtualAccount: json["virtualAccount"] == null ? null : json["virtualAccount"],
        nominalDonasi: json["nominalDonasi"] == null ? null : json["nominalDonasi"],
        category: json["category"] == null ? null : categoryValues.map[json["category"]],
        programAmalId: json["programAmalId"],
        customerName: json["customerName"] == null ? null : json["customerName"],
        customerPhone: json["customerPhone"] == null ? null : json["customerPhone"],
        customerUsername: json["customerUsername"] == null ? null : json["customerUsername"],
        customerEmail: json["customerEmail"] == null ? null : json["customerEmail"],
        nominalDibayar: json["nominalDibayar"] == null ? null : json["nominalDibayar"],
        donasiDate: json["donasiDate"] == null ? null : json["donasiDate"],
    );

    Map<String, dynamic> toJson() => {
        "virtualAccountRequestId": virtualAccountRequestId == null ? null : virtualAccountRequestId,
        "transactionId": transactionId == null ? null : transactionId,
        "virtualAccount": virtualAccount == null ? null : virtualAccount,
        "nominalDonasi": nominalDonasi == null ? null : nominalDonasi,
        "category": category == null ? null : categoryValues.reverse[category],
        "programAmalId": programAmalId,
        "customerName": customerName == null ? null : customerName,
        "customerPhone": customerPhone == null ? null : customerPhone,
        "customerUsername": customerUsername == null ? null : customerUsername,
        "customerEmail": customerEmail == null ? null : customerEmail,
        "nominalDibayar": nominalDibayar == null ? null : nominalDibayar,
        "donasiDate": donasiDate == null ? null : donasiDate,
    };
}

enum Category { ZAKAT, INFAQ, SODAQOH }

final categoryValues = EnumValues({
    "infaq": Category.INFAQ,
    "sodaqoh": Category.SODAQOH,
    "zakat": Category.ZAKAT
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
