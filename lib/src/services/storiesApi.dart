import 'package:flutter_jaring_ummat/src/models/storyByUser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';

import '../models/storiesModel.dart';

class NotFoundException implements Exception {
  String cause;
  NotFoundException(this.cause);
}

class StoriesApiProvider {
  Future<List<Story>> fetchAllStory() async {
    final response = await http.get(ALL_STORY_URL);
    if (response.statusCode == 200) {
      return compute(storyFromJson, response.body);
    } else {
      if (response.statusCode == 400) {
        throw NotFoundException("NOT_FOUND");
      }
      // throw NotFoundException("Unable to load ${response.toString()}");
    }
  }

  Future<http.Response> response() async {
    final response = await http.get(ALL_STORY_URL);
    return response;
  }

  Future<http.Response>storiesList(String userId) async {
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
