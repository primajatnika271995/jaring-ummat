import 'package:flutter_jaring_ummat/src/models/storyByUser.dart';
import 'package:http/http.dart' as http;

import '../services/storiesApi.dart';
import '../models/storiesModel.dart';

class StoriesRepository {
  final repository = StoriesApiProvider();
  
  Future<List<AllStoryModel>> fetchAllStory() => repository.fetchAllStory();
  Future<List<AllStoryModel>> fetchAllStoryWithoutFillter() => repository.fetchAllStoryWithoutFillter();
  Future<StoryByUserModel> fetchStoryByUser(String userId) => repository.fetchStoryUser(userId);
  Future<StoryByUserModel> fetchStoryByUserWithoutFillter(String userId) => repository.fetchStoryUserWithoutFillter(userId);
}