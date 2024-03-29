import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/models/commentModel.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter_jaring_ummat/src/config/urls.dart';

class CommentApiProvider {
  Client client = Client();

  Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  Future<List<Comment>> fetchAllComment() async {
    final response = await client.get(LIST_ALL_COMMENT_URL);
    print('ini responsenya status all komentar ${response.statusCode} =>');

    if (response.statusCode == 200) {
      return compute(commentFromJson, response.body);
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Comment>> fetchNewspaperComment(idNews) async {

    Uri uri = Uri.parse(LIST_ALL_COMMENT_NEWS_URL);
    var params = {
      "idNews": idNews
    };

    final uriParams = uri.replace(queryParameters: params);
    final response = await client.get(uriParams);
    print("ini response all comment berita ${response.statusCode}");

    if (response.statusCode == 200) {
      return compute(commentFromJson, response.body);
    }
  }

  Future<List<Comment>> fetchProgramAmalComment(idProgram) async {

    Uri uri = Uri.parse(LIST_ALL_COMMENT_PROGRAM_AMAL_URL);
    var params = {
      "idProgram": idProgram
    };

    final uriParams = uri.replace(queryParameters: params);
    final response = await client.get(uriParams);
    print("ini response all comment program amal ${response.statusCode}");

    if (response.statusCode == 200) {
      return compute(commentFromJson, response.body);
    }
  }

  Future saveComment(comment, idUser, idNews, idProgram) async {

    Map params = {
      "idNews": idNews,
      "idProgram": idProgram,
      "idStory": "",
      "idUser": idUser,
      "komentar": comment
    };

    final response = await client.post(SAVE_COMMENT_URL, headers: headers, body: json.encode(params));
    print("respones save=> ${response.statusCode}");
    if (response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Failed to Save Comment');
    }
  }
}