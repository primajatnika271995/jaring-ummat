import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/repository/ProgramAmalRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgramAmalBloc {
  SharedPreferences _preferences;
  String idUser;

  final repository = ProgramAmalRepository();
  final programAmalFetcher = PublishSubject<List<ProgramAmalModel>>();

  Observable<List<ProgramAmalModel>> get allProgramAmal =>
      programAmalFetcher.stream;

  fetchAllProgramAmal(String category) async {
    _preferences = await SharedPreferences.getInstance();
    idUser = _preferences.getString(USER_ID_KEY);

    if (idUser == null) {
      idUser = "55da0bdf-dafe-4164-a731-eb47b8877412";
    }
    
    List<ProgramAmalModel> listAllProgramAmal = await repository.fetchAllProgramAmal(idUser, category, "0", "20");
    programAmalFetcher.sink.add(listAllProgramAmal);
  }

  dispose() async {
    await programAmalFetcher.drain();
    programAmalFetcher.close();
  }
}

final bloc = ProgramAmalBloc();
