import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:http/http.dart' show Client;

class BeritaProvider {
  Client client = new Client();

  Future<List<BeritaModel>> fetchBerita(String idUserlogin, String category, String start, String limit) async {
    Uri uri = Uri.parse(BERITA_LIST_ALL_URL);

    var params = {
      "idUserLogin": idUserlogin,
      "category": category,
      "start": start,
      "limit": limit,
    };

    final uriParams = uri.replace(queryParameters: params);
    final response = await client.get(uriParams);

    print('_response_code : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(beritaModelFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('--> No Content');
    } else {
      throw Exception('--> Failed Fetch Berita');
    }
  }
}