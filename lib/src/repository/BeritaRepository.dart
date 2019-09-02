import 'package:flutter/widgets.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:flutter_jaring_ummat/src/services/beritaApi.dart';

class BeritaRepository {
  final api = BeritaProvider();
  Future save(BuildContext context, PostBerita value, String fullname, String idUser, String content) => api.save(context, value, fullname, idUser, content);
  Future<List<BeritaModel>> fetchAllBerita(String idUser, String category, String start, String limit) => api.fetchBerita(idUser, category, start, limit);
}