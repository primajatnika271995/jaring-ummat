import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import '../models/program_amal.dart';

class ProgramAmalService {

  Response response;
  Dio dio = new Dio();

  Future<ProgramAmalModel> getAllProgramAmal() async {

    var response = await dio.get(PROGRAM_AMAL_LIST_ALL_URL);

    try {
      if (response.statusCode == 200) {
        var data = await response.data;

        return ProgramAmalModel.fromJson(data);
      }
    } catch(exception) {
      print(exception.toString());
    }

    return null;
  }

//  Future<List<ProgramAmalModel>> getAllProgramAmal() async {
//
//     var response = await dio.get(PROGRAM_AMAL_LIST_ALL_URL);
//     return response.data;
//
////    return await http.get(PROGRAM_AMAL_LIST_ALL_URL, headers: headers);
//  }
//
////  Future<http.Response> findByIDProgramAmal(String idProgramAmal) async {
////    Map<String, String> headers = {
////      // 'Authorization': 'Basic amFyaW5ndW1hdDpqYXJpbmd1bWF0MTIz',
////      'Content-type': 'application/json',
////      'Accept': 'application/json',
////    };
////    var url = PROGRAM_AMAL_FINDBYID_URL + '$idProgramAmal';
////    return await http.get(url, headers: headers);
////  }

}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception : $_message";
  }
}
