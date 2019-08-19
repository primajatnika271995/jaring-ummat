import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:flutter_jaring_ummat/src/services/beritaApi.dart';

class BeritaRepository {
  final api = BeritaProvider();

  Future<List<BeritaModel>> fetchAllBerita(String idUser, String category, String start, String limit) => api.fetchBerita(idUser, category, start, limit);
}