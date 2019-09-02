import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/CreateProgramAmalResponse.dart';
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';

class ProgramAmalApiProvider {
  Dio dio = new Dio();
  Client client = Client();
  var params;
  Uri _uri;

  final String contentFile = "Program Amal";
  final String types = "image";

  Future save(BuildContext context, PostProgramAmal value, String idUser, String fullname, String content) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
    };

    Map params = {
      "idUser": idUser,
      "titleProgram": value.titleProgram,
      "category": value.category,
      "descriptionProgram": value.descriptionProgram,
      "totalDonasi": 0,
      "targetDonasi": value.targetDonasi,
      "endDonasi": value.endDonasi,
      "createdBy": fullname
    };

    final response = await client.post(PROGRAM_AMAL_SAVE_URL, headers: headers, body: json.encode(params));
    print('--> save_response ${response.statusCode}');
    if (response.statusCode == 201) {
      ResponseCreateProgramAmal value = responseCreateProgramAmalFromJson(response.body);
      print('id program amal : ${value.id}');
      saveContent(context, value.id, content);
      return response;
    }
  }

  Future<List<ProgramAmalModel>> fetchProgramAmal(
      String userId, String category, String offset, String limit) async {
    if (category.isEmpty) {
      print('No Category');
      params = {
        "idUser": userId,
        "limit": limit,
        "offset": offset,
      };
      _uri = Uri.parse(PROGRAM_AMAL_LIST_ALL_URL);
    } else {
      print('With Category : $category');
      params = {
        "idUser": userId,
        "limit": limit,
        "offset": offset,
        "category": category,
      };
      _uri = Uri.parse(PROGRAM_AMAL_LIST_BY_CATEGORY_URL);
    }

    final uriParams = _uri.replace(queryParameters: params);
    final response = await client.get(uriParams);

    print('_response_code : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(programAmalModelFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('--> No Content');
    } else {
      throw Exception('--> Failed Fetch Program Amal');
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
