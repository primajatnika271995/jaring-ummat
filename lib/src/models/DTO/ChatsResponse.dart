// To parse this JSON data, do
//
//     final chatsResponse = chatsResponseFromJson(jsonString);

import 'dart:convert';

List<ChatsResponse> chatsResponseFromJson(String str) => new List<ChatsResponse>.from(json.decode(str).map((x) => ChatsResponse.fromJson(x)));

String chatsResponseToJson(List<ChatsResponse> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class ChatsResponse {
    String id;
    String toId;
    String fromId;
    String message;
    int dateSent;
    dynamic dateSeen;

    ChatsResponse({
        this.id,
        this.toId,
        this.fromId,
        this.message,
        this.dateSent,
        this.dateSeen,
    });

    factory ChatsResponse.fromJson(Map<String, dynamic> json) => new ChatsResponse(
        id: json["id"] == null ? null : json["id"],
        toId: json["toId"] == null ? null : json["toId"],
        fromId: json["fromId"] == null ? null : json["fromId"],
        message: json["message"] == null ? null : json["message"],
        dateSent: json["dateSent"] == null ? null : json["dateSent"],
        dateSeen: json["dateSeen"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "toId": toId == null ? null : toId,
        "fromId": fromId == null ? null : fromId,
        "message": message == null ? null : message,
        "dateSent": dateSent == null ? null : dateSent,
        "dateSeen": dateSeen,
    };
}
