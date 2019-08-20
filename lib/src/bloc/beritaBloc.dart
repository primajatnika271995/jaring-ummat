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

    if (idUser == null) {
      idUser = "4b724e9e-3cdb-4b2f-8c72-070646b45fdf";
    }
    
    List<BeritaModel> listAllBerita = await repository.fetchAllBerita(idUser, category, "0", "20");
    beritaFetcher.sink.add(listAllBerita);
  }

  dispose() async {
    await beritaFetcher.drain();
    beritaFetcher.close();
  }
}

final bloc = BeritaBloc();