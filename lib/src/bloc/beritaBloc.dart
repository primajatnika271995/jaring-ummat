import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:flutter_jaring_ummat/src/repository/BeritaRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeritaBloc {
  SharedPreferences _preferences;
  String idUser;
  
  final repository = BeritaRepository();
  final beritaFetcher = PublishSubject<List<BeritaModel>>();

  Observable<List<BeritaModel>> get allBerita => beritaFetcher.stream;

  fetchAllBerita(String category) async {
    _preferences = await SharedPreferences.getInstance();
    idUser = _preferences.getString(USER_ID_KEY);
    
    List<BeritaModel> listAllBerita = await repository.fetchAllBerita("a108ec61-202b-410a-b7d2-b5017064ac95", category, "0", "20");
    beritaFetcher.sink.add(listAllBerita);
  }

  dispose() async {
    await beritaFetcher.drain();
    beritaFetcher.close();
  }
}

final bloc = BeritaBloc();