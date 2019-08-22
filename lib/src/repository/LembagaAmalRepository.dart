import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:flutter_jaring_ummat/src/services/lembagaAmalApi.dart';

class LembagaAmalRepository {
  final repository = LembagaAmalProvider();

  Future<List<LembagaAmalModel>> fetchAllComment(String idUser, String category, String offset, String limit) => repository.fetchAllLembagaAmal(idUser, category, offset, limit);
  Future<List<LembagaAmalModel>> fetchAllbyFollowed(String idUser) => repository.fetchLembagaAmalbyFollowed(idUser);
  Future followAccount(String idUser, String idAccountAmil) => repository.followLembagaAmal(idUser, idAccountAmil);
  Future unfollowAccount(String idUser, String idAccountAmil) => repository.unfollowLembagaAmal(idUser, idAccountAmil);

}