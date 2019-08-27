import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/ChatsResponse.dart';
import 'package:flutter_jaring_ummat/src/models/accountChatsModel.dart';
import 'package:flutter_jaring_ummat/src/repository/ChatsRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatsBloc {
  final repository = ChatsRepository();
  final chatsFetcher = PublishSubject<List<ChatsResponse>>();
  final accountFetcher = PublishSubject<List<AccountChats>>();
  SharedPreferences _prefereces;

  Observable<List<ChatsResponse>> get streamHistoryChat => chatsFetcher.stream;
  Observable<List<AccountChats>> get streamAccount => accountFetcher.stream;

  BehaviorSubject<List<ChatsResponse>> chatsBehavior = new BehaviorSubject<List<ChatsResponse>>();

  fetchChatsHistory(String idLembaga) async {
    _prefereces = await SharedPreferences.getInstance();
    var idAccount = _prefereces.getString(EMAIL_KEY);

    List<ChatsResponse> listAllChats = await repository.fetchHistoryChats(idAccount, idLembaga);
    chatsFetcher.sink.add(listAllChats);
    chatsBehavior.add(listAllChats);
  }

  fetchAccount() async {
    _prefereces = await SharedPreferences.getInstance();
    var idLembaga = _prefereces.getString(LEMABAGA_AMAL_ID);

    List<AccountChats> listAccount = await repository.fetchAccount(idLembaga);
    accountFetcher.sink.add(listAccount);
  }

  dispose() async {
    await chatsFetcher.drain();
    await accountFetcher.drain();
    accountFetcher.close();
    chatsFetcher.close();
  }
}

final bloc = ChatsBloc();