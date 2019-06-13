import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/models/newspaperModel.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter_jaring_ummat/src/config/urls.dart';

class NewspaperApiProvider {

  Client client = Client();

  Future<List<Newspaper>> fetchNewspaper() async {

    final response = await client.get(NEWS_GET_LIST);
    print("ini response code berita {} ${response.statusCode}");

    if (response.statusCode == 200) {
      return compute(newspaperFromJson, response.body);
    } else {
      throw Exception("Failed to load content");
    }
  }
}