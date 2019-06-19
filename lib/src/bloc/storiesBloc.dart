import '../repository/StoriesRepository.dart';
import '../models/storiesModel.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final repository = StoriesRepository();
  final storyFetchAll = PublishSubject<List<Story>>();

  Observable<List<Story>> get allStoryList => storyFetchAll.stream;

  fetchAllStories() async {
    List<Story> comment = await repository.fetchAllStory();
    storyFetchAll.sink.add(comment);
  }

  dispose() async {
    await storyFetchAll.drain();
    storyFetchAll.close();
  }
}

final bloc = StoriesBloc();