import 'package:flutter_jaring_ummat/src/models/bookmarkModel.dart';
import 'package:flutter_jaring_ummat/src/repository/BookmarkRepository.dart';
import 'package:rxdart/rxdart.dart';

class BookmarkBloc {
  final repository = new BookmarkRepository();

  final bookmarkListFetch = PublishSubject<BookmarkModel>();
  Observable<BookmarkModel> get streamBookmarkList => bookmarkListFetch.stream;

  fetchBookmarkList() async {
    BookmarkModel value = await repository.bookmarkList();
    bookmarkListFetch.sink.add(value);
  }

  dispose() async {
    await bookmarkListFetch.drain();
    bookmarkListFetch.close();
  }
}

final bookmarkBloc = BookmarkBloc();