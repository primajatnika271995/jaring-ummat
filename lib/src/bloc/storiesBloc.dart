import 'package:flutter_jaring_ummat/src/models/storyByUser.dart';
import 'package:http/http.dart' as http;

import '../repository/StoriesRepository.dart';
import '../models/storiesModel.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final repository = StoriesRepository();
  final storyFetchAll = PublishSubject<List<Story>>();
  final storyFetchByIdUser = PublishSubject<StoryByUser>();

  Observable<List<Story>> get allStoryList => storyFetchAll.stream;
  Observable<StoryByUser> get allStoryByIdUser => storyFetchByIdUser.stream;

  fetchAllStories() async {
    List<Story> story = await repository.fetchAllStory();
    storyFetchAll.sink.add(story);
  }

  fetchAllStoryByIdUser(String userId) async {
    StoryByUser story = await repository.fetchStoryByUser(userId);
    storyFetchByIdUser.sink.add(story);
  }

  dispose() async {
    await storyFetchAll.drain();
    await storyFetchByIdUser.drain();
    storyFetchAll.close();
    storyFetchByIdUser.close();
  }
}

final bloc = StoriesBloc();