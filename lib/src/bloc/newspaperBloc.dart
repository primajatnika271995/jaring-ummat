import 'package:flutter_jaring_ummat/src/models/newspaperModel.dart';
import 'package:flutter_jaring_ummat/src/repository/NewspaperRepository.dart';
import 'package:rxdart/rxdart.dart';

class NewspaperBloc {
  final _repository = NewspaperRepository();
  final _newspaperFetchThumbnail = PublishSubject<List<Newspaper>>();
  final _newspaperFetchOriginal = PublishSubject<List<Newspaper>>();

  Observable<List<Newspaper>> get allNewspaperThumbnail => _newspaperFetchThumbnail.stream;
  Observable<List<Newspaper>> get allNewspaperOriginal => _newspaperFetchOriginal.stream;

  BehaviorSubject<List<Newspaper>> list = new BehaviorSubject<List<Newspaper>>();

  fetchAllNewspaperThumbnail() async {
    List<Newspaper> newspaper = await _repository.fetchAllNewspaperThumbnail();
    _newspaperFetchThumbnail.sink.add(newspaper);
  }

  fetchAllNewspaperOriginal() async {
    List<Newspaper> newspaper = await _repository.fetchAllNewspaperOriginal();
    _newspaperFetchOriginal.sink.add(newspaper);
    list.add(newspaper);
  }

  dispose() async {
    await _newspaperFetchThumbnail.drain();
    await _newspaperFetchOriginal.drain();
    _newspaperFetchThumbnail.close();
    _newspaperFetchOriginal.close();
  }
}

final bloc = NewspaperBloc();