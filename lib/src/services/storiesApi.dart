import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import '../models/storiesModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';

class StoriesApiProvider {
  Client client = new Client();

  Future<List<Story>> fetchAllStory() async {
    final response = await client.get(ALL_STORY_URL);
    print('ini responsenya ${response.statusCode} =>');

    if (response.statusCode == 200) {
      return compute(storyFromJson, response.body);
    } else {
      print('Error code ${response.statusCode}');
    }
  }

  Future<http.Response> storiesList(String userId) async {
    var response = await http
        .get("${BASE_API_URL}/api/stories/list/${userId}");
    return response;
  }
}