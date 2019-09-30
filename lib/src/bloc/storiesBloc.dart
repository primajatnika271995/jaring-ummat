import 'package:flutter_jaring_ummat/src/models/storyByUser.dart';

import '../repository/StoriesRepository.dart';
import '../models/storiesModel.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
   final repository = StoriesRepository();
  final storyFetchAll = PublishSubject<List<AllStoryModel>>();
  final storyFetchByIdUser = PublishSubject<StoryByUserModel>();

  Observable<List<AllStoryModel>> get streamAllStory => storyFetchAll.stream;
  Observable<StoryByUserModel> get streamStoryByID => storyFetchByIdUser.stream;

  fetchAllStories() async {
    List<AllStoryModel> story = await repository.fetchAllStory();
    storyFetchAll.sink.add(story);
  }

  fetchAllStoryByIdUser(String userId) async {
    StoryByUserModel story = await repository.fetchStoryByUser(userId);
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