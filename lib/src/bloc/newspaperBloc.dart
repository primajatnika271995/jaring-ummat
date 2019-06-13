import 'package:flutter_jaring_ummat/src/models/newspaperModel.dart';
import 'package:flutter_jaring_ummat/src/repository/NewspaperRepository.dart';
import 'package:rxdart/rxdart.dart';

class NewspaperBloc {
  final _repository = NewspaperRepository();
  final _newspaperFetchContent = PublishSubject<List<Newspaper>>();

  Observable<List<Newspaper>> get allNewspaper => _newspaperFetchContent.stream;
  BehaviorSubject<List<Newspaper>> list = new BehaviorSubject<List<Newspaper>>();

  fetchAllNewspaperContent() async {
    List<Newspaper> newspaper = await _repository.fetchAllNewspaper();
    _newspaperFetchContent.sink.add(newspaper);
  }

  dispose() async {
    await _newspaperFetchContent.drain();
    _newspaperFetchContent.close();
  }
}

final bloc = NewspaperBloc();