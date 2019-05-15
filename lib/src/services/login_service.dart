import 'dart:async';

import 'package:flutter_jaring_ummat/src/config/urls.dart';

import 'package:http/http.dart' as http;

class LoginServices {

  Future<http.Response> login(String username, String password) async {
    Map<String, String> headers = {
//      'Content-type': 'application/json',
//      'Accept': 'application/json',
      'Authorization': 'Basic amFyaW5ndW1hdDpqYXJpbmd1bWF0MTIz'
    };

    var params = {
      "grant_type": "password",
      "username": username,
      "password": password
    };

    return await http.post(LOGIN_URL, headers: headers, body: params);

  }
}