import 'package:flutter/widgets.dart';
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/services/programAmalApi.dart';

class ProgramAmalRepository {
  final api = ProgramAmalApiProvider();
  Future save(BuildContext context, PostProgramAmal value, String idUser, String fullname, String content) => api.save(context, value, idUser, fullname, content);
  Future<List<ProgramAmalModel>> fetchAllProgramAmal(String idUserLogin, String category, String start, String limit) => api.fetchProgramAmal(idUserLogin, category, start, limit);
}
