import '../services/storiesApi.dart';
import '../models/storiesModel.dart';

class StoriesRepository {
  final repository = StoriesApiProvider();
  Future<List<Story>> fetchAllStory() => repository.fetchAllStory();

  
}