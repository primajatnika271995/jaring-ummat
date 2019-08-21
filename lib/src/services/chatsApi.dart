import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:http/http.dart' as http;

class ChatsProvider {

  Future<http.Response> fetchHistoryChats() async {
    return await http.post(CHATS_HISTORY + '/admin/primajatnika271995@gmail.com/history');
  }

}