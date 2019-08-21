import 'package:flutter_jaring_ummat/src/models/DTO/ChatsResponse.dart';
import 'package:flutter_jaring_ummat/src/repository/ChatsRepository.dart';
import 'package:rxdart/rxdart.dart';

class ChatsBloc {
  final repository = ChatsRepository();
  final chatsFetcher = PublishSubject<List<ChatsResponse>>();

  Observable<List<ChatsResponse>> get streamHistoryChat => chatsFetcher.stream;

   BehaviorSubject<List<ChatsResponse>> chatsBehavior = new BehaviorSubject<List<ChatsResponse>>();

  fetchChatsHistory() async {
    List<ChatsResponse> listAllChats = await repository.fetchHistoryChats();
    chatsFetcher.sink.add(listAllChats);
    chatsBehavior.add(listAllChats);
  }

  dispose() async {
    await chatsFetcher.drain();
    chatsFetcher.close();
  }
}

final bloc = ChatsBloc();