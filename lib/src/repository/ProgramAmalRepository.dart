import 'package:flutter_jaring_ummat/src/models/programAmalModel.dart';
import 'package:flutter_jaring_ummat/src/services/programAmalApi.dart';

class ProgramAmalRepository {
  final api = ProgramAmalApiProvider();
  Future<List<ProgramAmalModel>> fetchAllProgramAmal(String idUserLogin) => api.fetchProgramAmal(idUserLogin);
}
