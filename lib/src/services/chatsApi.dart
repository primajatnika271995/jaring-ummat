import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/ChatsResponse.dart';
import 'package:flutter_jaring_ummat/src/models/accountChatsModel.dart';
import 'package:http/http.dart' show Client;

class ChatsProvider {
  Client client = Client();

  Future<List<ChatsResponse>> fetchHistoryChats(
      String idLembaga, String idMuzakki) async {
    final response =
        await client.post(CHATS_HISTORY + '/$idLembaga/$idMuzakki/history');

    print('--> response_status_chats : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(chatsResponseFromJson, response.body);
    }
  }

  Future<List<AccountChats>> fetchChatsAccount(String idLembaga) async {
    Uri uri = Uri.parse(CHATS_ACCOUNT_FOLLOWED_AMIL);

    var params = {
      "idLembaga": idLembaga,
    };

    final uriParams = uri.replace(queryParameters: params);
    final response = await client.get(uriParams);

    print('--> response_account_chats ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(accountChatsFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('--> _no_content_');
    }
  }
}
