import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/likesModel.dart';
import 'package:flutter_jaring_ummat/src/models/listUserLikes.dart';
import 'package:http/http.dart' show Client;

class LikeUnlikeProvider {
  Client client = Client();
  Dio dio = new Dio();

  Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  Future<List<Likes>> fetchAllLikes() async {
    final response = await client.get(LIST_ALL_LIKE_URL);
    print('ini responsenya status all likes ${response.statusCode} =>');

    if (response.statusCode == 200) {
      return compute(likesFromJson, response.body);
    }
  }

  Future<List<ListUserLikes>> fetchAllUserLikeProgram(idProgram) async {
    Uri uri = Uri.parse(LIST_USER_LIKE_PROGRAM);

    var params = {
      "idProgram": idProgram
    };
    final uriParams = uri.replace(queryParameters: params);
    final response = await client.get(uriParams);

    if (response.statusCode == 200) {
      return compute(listUserLikesFromJson, response.body);
    }

  }

  Future saveLikes(idUser, idProgram, idNews) async {
    Map params = {
      "idUserLike": idUser,
      "idProgramLike": idProgram,
      "idNewsLike": idNews,
    };

    final response = await client.post(SAVE_LIKE_URL,
        headers: headers, body: json.encode(params));
    print("respones save=> ${response.statusCode}");
    if (response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Failed to Save Comment');
    }
  }

  Future unLikesProgramAmal(idUser, idProgram) async {
    Uri uri = Uri.parse(UNLIKE_PROGRAM_URL);

    var params = {"idUser": idUser, "idProgram": idProgram};

    final uriParams = uri.replace(queryParameters: params);
    final response = await client.get(uriParams);
    print("ini response all comment berita ${response.statusCode}");

    if (response.statusCode == 200) {
      print("unliked Program Amal");
    }
  }

  Future unLikesBerita(idUser, idBerita) async {
    Uri uri = Uri.parse(UNLIKE_BERITA_URL);

    var params = {"idUser": idUser, "idNews": idBerita};

    final uriParams = uri.replace(queryParameters: params);
    final response = await client.get(uriParams);
    print("ini response all comment berita ${response.statusCode}");

    if (response.statusCode == 200) {
      print("unliked Berita");
    }
  }

  Future<Response> likePost(
      String idNewsLike, String idProgramLike, String idUserLike) async {
    return await dio.post(SAVE_LIKE_URL, data: {
      "idNewsLike": idNewsLike,
      "idProgramLike": idProgramLike,
      "idUserLike": idUserLike
    });
  }

  Future<Response> unlikePost(String idProgram, String idUser) async {
    return await dio.post(UNLIKE_PROGRAM_URL,
        queryParameters: {"idProgram": idProgram, "idUser": idUser});
  }

  Future<Response> unlikeNews(String idNews, String idUser) async {
    return await dio.post(UNLIKE_BERITA_URL,
        queryParameters: {"idNews": idNews, "idUser": idUser});
  }
}
