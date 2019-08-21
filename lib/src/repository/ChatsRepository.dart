import 'package:flutter_jaring_ummat/src/models/DTO/ChatsResponse.dart';
import 'package:flutter_jaring_ummat/src/services/chatsApi.dart';

class ChatsRepository {
  final repository = ChatsProvider();

  Future<List<ChatsResponse>> fetchHistoryChats() => repository.fetchHistoryChats();
}