import 'package:flutter_jaring_ummat/src/models/newspaperModel.dart';
import 'package:flutter_jaring_ummat/src/repository/NewspaperRepository.dart';
import 'package:rxdart/rxdart.dart';

class NewspaperBloc {
  final _repository = NewspaperRepository();
  final _newspaperFetchThumbnail = PublishSubject<List<Newspaper>>();

  Observable<List<Newspaper>> get allNewspaperThumbnail => _newspaperFetchThumbnail.stream;

  fetchAllNewspaperThumbnail() async {
    List<Newspaper> newspaper = await _repository.fetchAllNewspaperThumbnail();
    _newspaperFetchThumbnail.sink.add(newspaper);
  }

  dispose() async {
    await _newspaperFetchThumbnail.drain();
    _newspaperFetchThumbnail.close();
  }
}

final bloc = NewspaperBloc();