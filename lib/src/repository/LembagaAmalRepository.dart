import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:flutter_jaring_ummat/src/services/lembagaAmalApi.dart';

class LembagaAmalRepository {
  final repository = LembagaAmalProvider();

  Future<List<LembagaAmal>> fetchAllComment(String idUser) => repository.fetchAllLembagaAmal(idUser);

}