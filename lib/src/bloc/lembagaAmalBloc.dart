import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:flutter_jaring_ummat/src/repository/LembagaAmalRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/preferences.dart';

class LembagaAmalBloc {
  final _repository = LembagaAmalRepository();
  final _lembagaAmalFetchAll = PublishSubject<List<LembagaAmal>>();

  SharedPreferences _preferences;

  Observable<List<LembagaAmal>> get allLembagaAmalList =>
      _lembagaAmalFetchAll.stream;

  fetchAllLembagaAmal() async {
    _preferences = await SharedPreferences.getInstance();
    var idUser = _preferences.getString(USER_ID_KEY);

    List<LembagaAmal> lembagaAmal = await _repository.fetchAllComment(idUser);
    _lembagaAmalFetchAll.sink.add(lembagaAmal);
  }

  dispose() async {
    await _lembagaAmalFetchAll.drain();
    _lembagaAmalFetchAll.close();
  }
}

final bloc = LembagaAmalBloc();