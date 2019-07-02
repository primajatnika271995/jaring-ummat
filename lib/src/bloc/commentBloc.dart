import 'package:flutter_jaring_ummat/src/models/commentModel.dart';
import 'package:flutter_jaring_ummat/src/repository/CommentRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/preferences.dart';

class CommentBloc {
  final _repository = CommentRepository();
  final _commentFetchAll = PublishSubject<List<Comment>>();
  final _commentFetchNews = PublishSubject<List<Comment>>();
  final _commentFetchProgramAmal = PublishSubject<List<Comment>>();

  final _comment = BehaviorSubject<String>();

  SharedPreferences _preferences;

  Observable<List<Comment>> get allCommentList => _commentFetchAll.stream;
  Observable<List<Comment>> get allCommentNewsList => _commentFetchNews.stream;
  Observable<List<Comment>> get allCommentProgramAmalList => _commentFetchProgramAmal.stream;

  Function(String) get updateComment => _comment.sink.add;

  fetchAllComment() async {
    List<Comment> comment = await _repository.fetchAllComment();
    _commentFetchAll.sink.add(comment);
  }

  fetchNewsComment(idNews) async {
    List<Comment> comment = await _repository.fetchNewspaperComment(idNews);
    _commentFetchNews.sink.add(comment);
  }

  fetchProgramAmalComment(idProgram) async {
    List<Comment> comment = await _repository.fetchProgramAmalComment(idProgram);
    _commentFetchProgramAmal.sink.add(comment);
  }

  saveComment(idNews, idProgram) async {
    _preferences = await SharedPreferences.getInstance();
    var idUser = _preferences.getString(USER_ID_KEY);
    _repository.addSaveComment(_comment.value, idUser, idNews, idProgram);
  }
  
  dispose() async {
    await _commentFetchAll.drain();
    await _commentFetchNews.drain();
    await _commentFetchProgramAmal.drain();
    _commentFetchAll.close();
    _commentFetchNews.close();
    _commentFetchProgramAmal.close();
    _comment.close();
  }
}

final bloc = CommentBloc();