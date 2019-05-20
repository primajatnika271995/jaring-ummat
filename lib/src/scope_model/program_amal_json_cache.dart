import 'package:dio/dio.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/program_amal.dart';

import '../config/urls.dart';

class ProgramAmalCache extends Model {
  Duration _cacheValidDuration;
  DateTime _lastFetchTime;
  List<ProgramAmalModel> _programAmalRecord;


  Response response;
  Dio dio = new Dio();


  ProgramAmalCache() {
    _cacheValidDuration = Duration(minutes: 30);
    _lastFetchTime = DateTime.now();
    _programAmalRecord = [];
  }

  //  Untuk RefreshAllRecords
  Future<ProgramAmalModel> refreshAllRecords(bool notifyListeners) async {
//    INI DATA RECORD

    final response = await dio.get(PROGRAM_AMAL_LIST_ALL_URL);
    Iterable list = response.data;
    _programAmalRecord = list.map((model) => ProgramAmalModel.fromJson(model)).toList();

    print("INI DATANYA BRO =>");
    print(_programAmalRecord[0].titleProgram);

    if (notifyListeners) this.notifyListeners();
  }

  Future<List<ProgramAmalModel>> getAllRecords(
      {bool forceRefresh = false}) async {

    print("SEBELUM REFRESH API KONDISI ==>");
    print(_programAmalRecord);
    print(_lastFetchTime);
    print(forceRefresh);

    bool shouldRefreshFromApi = (null == _programAmalRecord ||
        _programAmalRecord.isEmpty ||
        null == _lastFetchTime ||
        _lastFetchTime.isBefore(DateTime.now().subtract(_cacheValidDuration)) ||
        forceRefresh);

    print(shouldRefreshFromApi);

    if (shouldRefreshFromApi) await refreshAllRecords(false);


    return _programAmalRecord;
  }


}
