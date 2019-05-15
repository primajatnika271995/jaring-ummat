import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_jaring_ummat/src/config/urls.dart';

class ProgramAmalService {

  Future<http.Response> getAllProgramAmal() async {
    Map<String, String> headers = {
      'Authorization': 'Basic amFyaW5ndW1hdDpqYXJpbmd1bWF0MTIz'
      // 'Content-type': 'application/json',
      // 'Accept': 'application/json',
    };

    return await http.get(PROGRAM_AMAL_LIST_ALL_URL, headers: headers);
  }

  Future<http.Response> findByIDProgramAmal(String idProgramAmal) async {
    Map<String, String> headers = {
      // 'Authorization': 'Basic amFyaW5ndW1hdDpqYXJpbmd1bWF0MTIz',
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var url = PROGRAM_AMAL_FINDBYID_URL + '$idProgramAmal';
    return await http.get(url, headers: headers);
  }

}
