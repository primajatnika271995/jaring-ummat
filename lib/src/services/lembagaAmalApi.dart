import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter_jaring_ummat/src/config/urls.dart';

class LembagaAmalProvider {
  Client client = Client();

  Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  Future<List<LembagaAmal>> fetchAllLembagaAmal(idUser) async {
    Uri uri = Uri.parse(LIST_ALL_LEMBAGA_AMAL);
    var params = {
      "idUserLogin": idUser,
      "limitCount": "15"
    };

    final uriParams = uri.replace(queryParameters: params);
    final response = await client.get(uriParams);
    print("ini response all lembaga amal ${response.statusCode}");

    if (response.statusCode == 200) {
      return compute(lembagaAmalFromJson, response.body);
    }
  }
}