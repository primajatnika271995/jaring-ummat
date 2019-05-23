import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';

import '../config/urls.dart';

class CommentService {
  Dio dio = new Dio();

  Future<Response> saveComment(String idNews, String idProgram, String idStory,
      String idUser, String komentar) async {
    return await dio.post(SAVE_COMMENT_URL, data: {
      "idNews": idNews,
      "idProgram": idProgram,
      "idStory": idStory,
      "idUser": idUser,
      "komentar": komentar
    });
  }

  Future<Response> listCommentBerita(String idNews) async {
    return await dio.get(LIST_ALL_COMMENT_NEWS_URL, queryParameters: {
      "idNews": idNews
    });
  }

  Future<Response> listCommentProgram(String idProgram) async {
    return await dio.get(LIST_ALL_COMMENT_PROGRAM_AMAL_URL, queryParameters: {
      "idProgram": idProgram
    });
  }

  Future<Response> userById(String id) async {
    return await dio.get(USER_BY_ID_URL + '${id}');
  }
}
