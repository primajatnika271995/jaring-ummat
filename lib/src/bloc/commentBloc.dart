import 'package:flutter_jaring_ummat/src/models/commentModel.dart';
import 'package:flutter_jaring_ummat/src/repository/CommentRepository.dart';
import 'package:rxdart/rxdart.dart';

class CommentBloc {
  final _repository = CommentRepository();
  final _commentFetchAll = PublishSubject<List<Comment>>();
  final _commentFetchNews = PublishSubject<List<Comment>>();

  Observable<List<Comment>> get allCommentList => _commentFetchAll.stream;
  Observable<List<Comment>> get allCommentNewsList => _commentFetchNews.stream;

  fetchAllComment() async {
    List<Comment> comment = await _repository.fetchAllComment();
    _commentFetchAll.sink.add(comment);
  }

  fetchNewsComment(idNews) async {
    List<Comment> comment = await _repository.fetchNewspaperComment(idNews);
    _commentFetchNews.sink.add(comment);
  }
  
  dispose() async {
    await _commentFetchAll.drain();
    await _commentFetchNews.drain();
    _commentFetchAll.close();
    _commentFetchNews.close();
  }
}

final bloc = CommentBloc();