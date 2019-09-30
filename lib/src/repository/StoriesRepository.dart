import 'package:flutter_jaring_ummat/src/models/storyByUser.dart';
import 'package:http/http.dart' as http;

import '../services/storiesApi.dart';
import '../models/storiesModel.dart';

class StoriesRepository {
  final repository = StoriesApiProvider();
  
  Future<List<AllStoryModel>> fetchAllStory() => repository.fetchAllStory();
  Future<StoryByUserModel> fetchStoryByUser(String userId) => repository.fetchStoryUser(userId);
}