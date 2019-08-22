import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/ChatsResponse.dart';
import 'package:http/http.dart' show Client;

class ChatsProvider {

  Client client = Client();

  Future<List<ChatsResponse>> fetchHistoryChats(String idLembaga, String idMuzakki) async {
    final response = await client.post(CHATS_HISTORY + '/$idLembaga/$idMuzakki/history');
    
    print('--> response_status_chats : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(chatsResponseFromJson, response.body);
    }
  }

}