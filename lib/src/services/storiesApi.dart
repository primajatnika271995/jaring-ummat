import 'package:flutter_jaring_ummat/src/models/storiesModel.dart';
import 'package:flutter_jaring_ummat/src/models/storyByUser.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;
import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';

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

  Future<List<AllStoryModel>> fetchAllStory() async {
    final response = await http.get(ALL_STORY_URL);
    if (response.statusCode == 200) {
      return compute(allStoryModelFromJson, response.body);
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


