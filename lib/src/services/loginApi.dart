import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/LoginResponse.dart';
import 'package:flutter_jaring_ummat/src/models/muzakkiUserDetails.dart';
import 'package:flutter_jaring_ummat/src/views/components/flushbarContainer.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;

class LoginApiProvider {
  Client client = new Client();

  final String grantType = "password";

  Future<LoginResponse> login(BuildContext context, String username, String password) async {

    Map<String, String> headers = {
      'Authorization': 'Basic amFyaW5ndW1hdDpqYXJpbmd1bWF0MTIz'
    };

    var params = {
      "grant_type": grantType,
      "username": username,
      "password": password
    };

    final response = await client.post(LOGIN_URL, headers: headers, body: params);

    print('--> login_response ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(loginResponseFromJson, response.body);
    } else if (response.statusCode == 400) {
      flushBar(context, "Email atau Password tidak cocok", 3);
    } return null;
  }

  Future<MuzakkiUserDetails> fetchDetails(BuildContext context, String email) async {
    
    Uri uri = Uri.parse(USER_DETAILS_URL);

    var params = {"email": email};

    final uriParams = uri.replace(queryParameters: params);
    final response = await client.get(uriParams);
    
    print('--> user_details_response ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(muzakkiUserDetailsFromJson, response.body);
    } else if (response.statusCode == 201) {}
    return null;
  }

  Future<http.Response> getUserDetails(String email) async {
    Uri uri = Uri.parse(USER_DETAILS_URL);

    var params = {
      "email": email,
    };

    final uriParams = uri.replace(queryParameters: params);
    return await client.get(uriParams);
  }
}
