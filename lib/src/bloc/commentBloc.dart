import 'package:flutter_jaring_ummat/src/models/commentModel.dart';
import 'package:flutter_jaring_ummat/src/repository/CommentRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/preferences.dart';

class CommentBloc {
  final _repository = CommentRepository();
  final _commentFetchAll = PublishSubject<List<Comment>>();
  final _commentFetchNews = PublishSubject<List<Comment>>();

  final _comment = BehaviorSubject<String>();

  SharedPreferences _preferences;

  Observable<List<Comment>> get allCommentList => _commentFetchAll.stream;
  Observable<List<Comment>> get allCommentNewsList => _commentFetchNews.stream;

  Function(String) get updateComment => _comment.sink.add;

  fetchAllComment() async {
    List<Comment> comment = await _repository.fetchAllComment();
    _commentFetchAll.sink.add(comment);
  }

  fetchNewsComment(idNews) async {
    List<Comment> comment = await _repository.fetchNewspaperComment(idNews);
    _commentFetchNews.sink.add(comment);
  }

  saveComment(idNews) async {
    _preferences = await SharedPreferences.getInstance();
    var idUser = _preferences.getString(USER_ID_KEY);
    _repository.addSaveComment(_comment.value, idUser, idNews);
  }
  
  dispose() async {
    await _commentFetchAll.drain();
    await _commentFetchNews.drain();
    _commentFetchAll.close();
    _commentFetchNews.close();
    _comment.close();
  }
}

final bloc = CommentBloc();