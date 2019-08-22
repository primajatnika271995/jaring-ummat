import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/ChatsResponse.dart';
import 'package:flutter_jaring_ummat/src/repository/ChatsRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatsBloc {
  final repository = ChatsRepository();
  final chatsFetcher = PublishSubject<List<ChatsResponse>>();
  SharedPreferences _preferences;

  Observable<List<ChatsResponse>> get streamHistoryChat => chatsFetcher.stream;

   BehaviorSubject<List<ChatsResponse>> chatsBehavior = new BehaviorSubject<List<ChatsResponse>>();

  fetchChatsHistory(String idLembaga) async {

    _preferences = await SharedPreferences.getInstance();
    var idMuzakki = _preferences.getString(EMAIL_KEY);

    List<ChatsResponse> listAllChats = await repository.fetchHistoryChats(idLembaga, idMuzakki);
    chatsFetcher.sink.add(listAllChats);
    chatsBehavior.add(listAllChats);
  }

  dispose() async {
    await chatsFetcher.drain();
    chatsFetcher.close();
  }
}

final bloc = ChatsBloc();