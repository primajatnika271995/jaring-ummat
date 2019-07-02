import 'package:flutter_jaring_ummat/src/models/likesModel.dart';
import 'package:flutter_jaring_ummat/src/models/listUserLikes.dart';
import 'package:flutter_jaring_ummat/src/services/likeUnlikeApi.dart';

class LikesRepository {
  final repository = LikeUnlikeProvider();

  Future<List<Likes>> fetchAllLikes() => repository.fetchAllLikes();
  Future<List<ListUserLikes>> fetchUserLikeProgram(String idProgram) => repository.fetchAllUserLikeProgram(idProgram);
  Future<List<ListUserLikes>> fetchUserLikeBerita(String idBerita) => repository.fetchAllUserLikeBerita(idBerita);

  Future addSaveLikes(String idUser, String idProgram, String idNews)  => repository.saveLikes(idUser, idProgram, idNews);
  Future unlikeProgram(String idUser, String idProgram) => repository.unLikesProgramAmal(idUser, idProgram);
  Future unlikeBerita(String idUser, String idBerita) => repository.unLikesBerita(idUser, idBerita);
}