import 'package:flutter_jaring_ummat/src/models/bookmarkModel.dart';
import 'package:flutter_jaring_ummat/src/services/bookmarkApi.dart';

class BookmarkRepository {
  final provider = BookmarkProvider();

  Future<BookmarkModel> bookmarkList() => provider.bookmarkList();
}