import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:flutter_jaring_ummat/src/repository/LembagaAmalRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/preferences.dart';

class LembagaAmalBloc {
  final _repository = LembagaAmalRepository();
  final _lembagaAmalFetcher = PublishSubject<List<LembagaAmalModel>>();

  SharedPreferences _preferences;

  Observable<List<LembagaAmalModel>> get allLembagaAmalList => _lembagaAmalFetcher.stream;

  fetchAllLembagaAmal(String category) async {
    _preferences = await SharedPreferences.getInstance();
    var idUser = _preferences.getString(USER_ID_KEY);

    List<LembagaAmalModel> lembagaAmal = await _repository.fetchAllComment(idUser, category, "0", "10");
    _lembagaAmalFetcher.sink.add(lembagaAmal);
  }

  followAccount(String idAccountAmil) async {
    _preferences = await SharedPreferences.getInstance();
    var idUser = _preferences.getString(USER_ID_KEY);

    _repository.followAccount(idUser, idAccountAmil);
  }

  unfollow(String idAccountAmil) async {
    _preferences = await SharedPreferences.getInstance();
    var idUser = _preferences.getString(USER_ID_KEY);

    _repository.unfollowAccount(idUser, idAccountAmil);
  }

  dispose() async {
    await _lembagaAmalFetcher.drain();
    _lembagaAmalFetcher.close();
  }
}

final bloc = LembagaAmalBloc();