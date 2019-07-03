import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/repository/ProgramAmalRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProgramAmalBloc {

  SharedPreferences _preferences;
  String idUserLogin;

  final repository = ProgramAmalRepository();
  final programAmalFecthData = PublishSubject<List<ProgramAmalModel>>();

  Observable<List<ProgramAmalModel>> get streamProgramAmal => programAmalFecthData.stream;

  fetchAllProgramAmal(String category) async {
    print('Masuk Method FetchProgramAmal');
    _preferences = await SharedPreferences.getInstance();
    idUserLogin = _preferences.getString(USER_ID_KEY);
    List<ProgramAmalModel> listAllProgramAmal = await repository.fetchAllProgramAmal(idUserLogin, category, "0", "20").catchError((err) => programAmalFecthData.addError(err));
    programAmalFecthData.sink.add(listAllProgramAmal);
  }

  dispose() async {
    await programAmalFecthData.drain();
    programAmalFecthData.close();
  }
}

final bloc = ProgramAmalBloc();
