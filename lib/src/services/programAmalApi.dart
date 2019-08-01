import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:http/http.dart';

class ProgramAmalApiProvider {
  Client client = Client();

  Future<List<ProgramAmalModel>> fetchProgramAmal(String idUserLogin, String category, String start, String limit) async {

    Uri uri = Uri.parse(PROGRAM_AMAL_LIST_ALL_URL);
    var params = {
      "idUserLogin": idUserLogin,
      "limit": limit,
      "start": start,
      "category": category
    };

    final uriParams = uri.replace(queryParameters: params);

    print(" URL API fetchProgramAmal $uriParams");
    print("Category ${category}");

    final response = await client.get("http://139.162.15.91/jaring-ummat/api/program-amal/list?idUserLogin=&start=0&limit=30&category=${category}");

    print ('Response From Program Amal Api ${response.statusCode}');
    if (response.statusCode == 200) {
      print (response.body);
      return compute(programAmalModelFromJson, response.body);
    } else if (response.statusCode == 204) {
      print("No Content");
    }
    else {
      print('Failed to load POST AMAL');
    }

  }
}
