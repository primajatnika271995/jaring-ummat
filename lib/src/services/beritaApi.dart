import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<http.Response> beritaByID(String idBerita) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var idUser = _pref.getString(USER_ID_KEY);
    var token = _pref.getString(ACCESS_TOKEN_KEY);

    Map<String, String> header = {'Authorization': 'Bearer $token'};

    var params = {
      "idUser": idUser,
      "idBerita": idBerita,
    };

    Uri uri = Uri.parse(BERITA_FINDBYID_URL);
    final uriParams = uri.replace(queryParameters: params);

    return await client.get(uriParams, headers: header);
  }
}
