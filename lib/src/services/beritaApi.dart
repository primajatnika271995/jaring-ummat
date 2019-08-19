import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:http/http.dart' show Client;

class BeritaProvider {
  Client client = new Client();
  var params;
  Uri _uri;

  Future<List<BeritaModel>> fetchBerita(String idUser, String category, String offset, String limit) async {

    if (category.isEmpty) {
      params = {
        "idUser": idUser,
        "offset": offset,
        "limit": limit,
      };
      _uri =  Uri.parse(BERITA_LIST_ALL_URL);
    } else {
      params = {
        "idUser": idUser,
        "category": category,
        "offset": offset,
        "limit": limit,
      };
      _uri =  Uri.parse(BERITA_LIST_ALL_BY_CATEGORY_URL);
    }

    final uriParams = _uri.replace(queryParameters: params);
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
