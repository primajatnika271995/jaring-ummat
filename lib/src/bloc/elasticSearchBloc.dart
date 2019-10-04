import 'package:flutter_jaring_ummat/src/models/elasticSearchModel.dart';
import 'package:flutter_jaring_ummat/src/repository/elasticSearchRepository.dart';
import 'package:rxdart/rxdart.dart';

class ElasticSearchBloc {
  final repository = ElasticSearchRepository();
  final fetchData = PublishSubject<ElasticSearchModel>();

  Observable<ElasticSearchModel> get streamData => fetchData.stream;

  fetchElasticData(String dataSearch) async {
    ElasticSearchModel value = await repository.fetchElasticSearch(dataSearch);
    fetchData.sink.add(value);
  }

  dispose() async {
    await fetchData.drain();
    fetchData.close();
  }
}

final bloc = ElasticSearchBloc();