import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';

class ProgramAmalApiProvider {
  Client client = Client();
  var params;
  Uri _uri;

  Future<List<ProgramAmalModel>> fetchProgramAmal(String userId, String category, String offset, String limit) async {

    if (category.isEmpty) {
      print('No Category');
      params = {
        "idUser": userId,
        "limit": limit,
        "offset": offset,
      };
      _uri =  Uri.parse(PROGRAM_AMAL_LIST_ALL_URL);
    } else {
      print('With Category : $category');
      params = {
        "idUser": userId,
        "limit": limit,
        "offset": offset,
        "category": category,
      };
      _uri =  Uri.parse(PROGRAM_AMAL_LIST_BY_CATEGORY_URL);
    }

    final uriParams = _uri.replace(queryParameters: params);
    final response = await client.get(uriParams);

    print('_response_code : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(programAmalModelFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('--> No Content');
    } else {
      throw Exception('--> Failed Fetch Program Amal');
    }

  }
}
