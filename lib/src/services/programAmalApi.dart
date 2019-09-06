import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgramAmalApiProvider {
  
  /*
   * Client from Http
   */
  Client client = Client();

  /*
   * Variable Temp
   */
  var params;
  Uri uri;

  Future<List<ProgramAmalModel>> fetchProgramAmal(String userId, String category, String offset, String limit) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);

    Map<String, String> header = {
      'Authorization': 'Bearer $token'
    };

    if (category.isEmpty) {
      print('No Category');
      params = {
        "idUser": userId,
        "limit": limit,
        "offset": offset,
      };
      uri = Uri.parse(PROGRAM_AMAL_LIST_ALL_URL);
    } else {
      print('With Category : $category');
      params = {
        "idUser": userId,
        "limit": limit,
        "offset": offset,
        "category": category,
      };
      uri = Uri.parse(PROGRAM_AMAL_LIST_BY_CATEGORY_URL);
    }

    final uriParams = uri.replace(queryParameters: params);
    final response = await client.get(
      uriParams,
      headers: header
    );

    print('--> Response Program Amal : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(programAmalModelFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('--> No Content');
    } else {
      throw Exception('--> Failed Fetch Program Amal');
    }
  }
}
