import 'package:flutter_jaring_ummat/src/models/programAmalModel.dart';
import 'package:flutter_jaring_ummat/src/repository/programAmalRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';


class ProgramAmalBloc {

  SharedPreferences _preferences;

  final repository = ProgramAmalRepository();
  final programAmalFecthData = PublishSubject<List<ProgramAmalModel>>();

  Observable<List<ProgramAmalModel>> get streamProgramAmal => programAmalFecthData.stream;

  BehaviorSubject<List<ProgramAmalModel>> list = new BehaviorSubject<List<ProgramAmalModel>>();

  fetchAllProgramAmal() async {
    print('Masuk Method FetchProgramAmal');
    _preferences = await SharedPreferences.getInstance();
    var idUser = _preferences.getString(USER_ID_KEY);
    List<ProgramAmalModel> listAllProgramAmal = await repository.fetchAllProgramAmal(idUser);
    programAmalFecthData.sink.add(listAllProgramAmal);
    list.add(listAllProgramAmal);
  }

  dispose() async {
    await programAmalFecthData.drain();
    programAmalFecthData.close();
  }
}

final bloc = ProgramAmalBloc();
