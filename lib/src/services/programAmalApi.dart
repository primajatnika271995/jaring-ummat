import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/models/programAmalModel.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:http/http.dart';

class ProgramAmalApiProvider {
  Client client = Client();

  Future<List<ProgramAmalModel>> fetchProgramAmal(String idUserLogin) async {

    Uri uri = Uri.parse(PROGRAM_AMAL_LIST_ALL_URL);
    var params = {
      "idUserLogin": idUserLogin
    };

    final uriParams = uri.replace(queryParameters: params);
    final response = await client.get(uriParams);

    print ('Response From Program Amal Api ${response.statusCode}');
    if (response.statusCode == 200) {
      print (response.body);
      return compute(programAmalModelFromJson, response.body);
    } else {
      throw Exception("Failed to load berita thumbnails");
    }

  }
}
