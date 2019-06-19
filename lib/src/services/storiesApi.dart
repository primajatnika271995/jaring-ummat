import 'package:http/http.dart' show Client;
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
      throw Exception('Failed to load');
    }
  }
}