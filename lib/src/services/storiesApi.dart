import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/FilePathResponse.dart';
import 'package:flutter_jaring_ummat/src/models/cloudinaryUploadImageModel.dart';
import 'package:flutter_jaring_ummat/src/models/storiesModel.dart';
import 'package:flutter_jaring_ummat/src/models/storyByUser.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;
import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotFoundException implements Exception {
  String cause;

  NotFoundException(this.cause);
}

class StoriesApiProvider {
  Client client = new Client();
  String token;

  Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  Future<http.Response> hideOrShow() async {
    final response = await http.get(ALL_STORY_URL);
    return response;
  }

  Future<http.Response> storiesList(String userId) async {
    var response = await http.get(STORY_BY_ID_URL + '$userId');
    return response;
  }

  Future<http.Response> saveStoryData(String userId, String createdBy) async {
    Map params = {
      "userId": userId,
      "createdBy": createdBy,
    };

    var body = json.encode(params);
    return await http.post(BASE_API_URL + '/api/stories/',
        body: body, headers: {'Content-type': 'application/json'});
  }

  Future<List<AllStoryModel>> fetchAllStory() async {
    final response = await http.get(ALL_STORY_URL);
    if (response.statusCode == 200) {
      return compute(allStoryModelFromJson, response.body);
    }
    return null;
  }

  Future<FilePathResponseModel> saveFilepath(
      BuildContext context, FilePathResponseModel data, String idUser) async {
    Map params = {
      "idUser": idUser,
      "resourceType": data.resourceType,
      "urlType": data.urlType,
      "url": data.url,
    };

    final response = await client.post(FILE_PATH_SAVE,
        headers: headers, body: json.encode(params));

    if (response.statusCode == 201) {
      FilePathResponseModel value =
          filePathResponseModelFromJson(response.body);
      return value;
    }
    return null;
  }

  Future<StoryByUserModel> fetchStoryUser(String userId) async {
    final response = await http.get(STORY_BY_ID_URL + userId);
    if (response.statusCode == 200) {
      return compute(storyByUserModelFromJson, response.body);
    }
    return null;
  }
}
