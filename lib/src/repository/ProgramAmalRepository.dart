import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/services/programAmalApi.dart';

class ProgramAmalRepository {
  final api = ProgramAmalApiProvider();
  Future save(PostProgramAmal value, String idUser, String fullname) => api.save(value, idUser, fullname);
  Future<List<ProgramAmalModel>> fetchAllProgramAmal(String idUserLogin, String category, String start, String limit) => api.fetchProgramAmal(idUserLogin, category, start, limit);
}
