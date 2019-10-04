import 'package:flutter_jaring_ummat/src/models/elasticSearchModel.dart';
import 'package:flutter_jaring_ummat/src/services/elasticSearchApi.dart';

class ElasticSearchRepository {
  final provider = ElasticSearchProvider();

  Future<ElasticSearchModel> fetchElasticSearch(String dataSearch) => provider.fetchElasticSearch(dataSearch);
}