import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/bookmarkModel.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkProvider {
  Client _client = new Client();

  Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  Future<BookmarkModel> bookmarkList() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);
    var idUser = _pref.getString(USER_ID_KEY);

    Map<String, String> header = {'Authorization': 'Bearer $token'};

    var params = {
      "idUser": idUser
    };
    
    Uri uri = Uri.parse(BOOKMARK_LIST_URL);
    final urlParams = uri.replace(queryParameters: params);
    final response = await _client.get(urlParams, headers: header);

    print('Response List Bookmark : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(bookmarkModelFromJson, response.body);
    } return null;
  }

  Future<http.Response> bookmarkProgram(String idUser, String idContent, String type) async {
    Map params = {
      "idUser": idUser,
      "idContent": idContent,
      "type": type,
    };

    final response = await _client.post(BOOKMARK_CONTENT, headers: headers, body: json.encode(params));
    print('Bookmark Response : ${response.statusCode}');
    if (response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Failed to Bookmark Program Amal');
    }
  }

  Future<http.Response> unbookmarkProgram(String idUser, String idContent) async {
    var params = {
      "idUser": idUser,
      "idContent": idContent,
    };
    
    Uri uri = Uri.parse(UNBOOKMARK_CONTENT);
    final uriParams = uri.replace(queryParameters: params);

    final response = await _client.post(uriParams);
    print('Unbookmark Response : ${response.statusCode}');
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed Unbookmark Program Amal');
    }
  }

}