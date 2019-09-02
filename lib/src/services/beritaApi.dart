import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/CreateBeritaResponse.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:http/http.dart' show Client;

class BeritaProvider {
  Dio dio = new Dio();
  Client client = new Client();
  var params;
  Uri _uri;

  final String contentFile = "Berita";
  final String types = "image";

  Future<List<BeritaModel>> fetchBerita(String idUser, String category, String offset, String limit) async {

    if (category.isEmpty) {
      params = {
        "idUser": idUser,
        "offset": offset,
        "limit": limit,
      };
      _uri =  Uri.parse(BERITA_LIST_ALL_URL);
    } else {
      params = {
        "idUser": idUser,
        "category": category,
        "offset": offset,
        "limit": limit,
      };
      _uri =  Uri.parse(BERITA_LIST_ALL_BY_CATEGORY_URL);
    }

    final uriParams = _uri.replace(queryParameters: params);
    final response = await client.get(uriParams);

    print('_response_code : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(beritaModelFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('--> No Content');
    } else {
      throw Exception('--> Failed Fetch Berita');
    }
  }

  Future save(BuildContext context, PostBerita value, String fullname, String idUser, String content) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
    };

    Map params = {
      "idUser": idUser,
      "title": value.titleBerita,
      "category": value.category,
      "description": value.descriptionBerita,
      "createdBy": fullname
    };

    final response = await client.post(BERITA_SAVE_URL, headers: headers, body: json.encode(params));
    print('--> save_response ${response.statusCode}');
    if (response.statusCode == 201) {
      ResponseCreateBerita value = responseCreateBeritaFromJson(response.body);
      print('id berita : ${value.id}');
      saveContent(context, value.id, content);
    }
  }

  Future saveContent(BuildContext context, contentId, content) async {
    // mapping value
    FormData value = new FormData.from({
      "contentId": contentId,
      "contentFile": contentFile,
      "types": types,
      "content": new UploadFileInfo(new File("./$content"), content),
    }); 

    final response = await dio.post(UPLOADER_MEDIA_IMAGE, data: value);
    print('--> response content : ${response.statusCode}');
    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      print('Can\'t save content');
    }
  }


}
