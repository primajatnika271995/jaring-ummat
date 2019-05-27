import 'package:flutter_jaring_ummat/src/models/commentModel.dart';
import 'package:flutter_jaring_ummat/src/services/commentApi.dart';

class CommentRepository {
  final repository = CommentApiProvider();

  Future<List<Comment>> fetchAllComment() => repository.fetchAllComment();
  Future<List<Comment>> fetchNewspaperComment(String idNews) => repository.fetchNewspaperComment(idNews);

  Future addSaveComment(String comment, String idUser, String idNews) => repository.saveComment(comment, idUser, idNews);
  
}