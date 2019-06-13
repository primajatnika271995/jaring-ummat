import 'package:flutter_jaring_ummat/src/models/newspaperModel.dart';
import 'package:flutter_jaring_ummat/src/services/newspaperApi.dart';

class NewspaperRepository {

  final repository = NewspaperApiProvider();

  Future<List<Newspaper>> fetchAllNewspaper() => repository.fetchNewspaper();
  

}