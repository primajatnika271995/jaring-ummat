// To parse this JSON data, do
//
//     final chatsResponse = chatsResponseFromJson(jsonString);

import 'dart:convert';

ChatsResponse chatsResponseFromJson(String str) => ChatsResponse.fromJson(json.decode(str));

String chatsResponseToJson(ChatsResponse data) => json.encode(data.toJson());

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
