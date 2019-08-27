import 'dart:convert';
import 'dart:io';

import 'package:flutter_jaring_ummat/src/models/storiesModel.dart';
import 'package:flutter_jaring_ummat/src/models/storyByUser.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotFoundException implements Exception {
  String cause;
  NotFoundException(this.cause);
}

class StoriesApiProvider {
  Response response;
  Dio dio = new Dio();
  String token;
  SharedPreferences _preferences;

  Future<http.Response> saveStoryData(String userId, String createdBy) async {
//    var userId = _preferences.getString('userId');
//    var creator = _preferences.getString('fullname');

    Map params = {"userId": userId, "createdBy": createdBy};

    var body = json.encode(params);
    return await http.post(BASE_API_URL + '/api/stories/',
        body: body, headers: {'Content-type': 'application/json'});
  }

  Future<Response> uploadVideo(String contentId, String video_selected) async {
    FormData formData = new FormData.from({
      "types": "video",
      "contentFile": "Story",
      "contentId": contentId,
      "content":
          new UploadFileInfo(new File("./${video_selected}"), video_selected),
    });
    return response = await dio.post(
        BASE_API_UPLOADER_URL + '/api/media/upload/video',
        data: formData);
  }

  Future<Response> uploadImage(String contentId, String image_selected) async {
    FormData formData = new FormData.from({
      "types": "image",
      "contentFile": "Storie",
      "contentId": contentId,
      "content":
          new UploadFileInfo(new File("./${image_selected}"), image_selected),
    });
    return response = await dio.post(
        BASE_API_UPLOADER_URL + '/api/media/upload/image',
        data: formData);
  }

  Future<List<Story>> fetchAllStory() async {
    final response = await http.get(ALL_STORY_URL);
    if (response.statusCode == 200) {
      return compute(storyFromJson, response.body);
    } else {
      if (response.statusCode == 400) {
        throw NotFoundException("NOT_FOUND");
      }
    }
  }

  Future<http.Response> responses() async {
    final response = await http.get(ALL_STORY_URL);
    return response;
  }

  Future<http.Response> storiesList(String userId) async {
    var response = await http.get("${BASE_API_URL}/api/stories/list/${userId}");
    return response;
  }

  Future<StoryByUser> fetchStoryUser(String userId) async {
    final response = await http.get(STORY_BY_ID_URL + userId);
    print('Response Stories by Id ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(storyByUserFromJson, response.body);
    } else {
      if (response.statusCode == 400) {
        throw NotFoundException("NOT_FOUND");
      }
      throw NotFoundException("Unable to load ${response.toString()}");
    }
  }
}
