import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LembagaAmalProvider {
  Client client = Client();

  Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  Future<List<LembagaAmalModel>> fetchAllLembagaAmal(
      String idUser, String category, String offset, String limit) async {
    var params;
    Uri _uri;

    if (category.isEmpty) {
      params = {
        "idUser": idUser,
        "limit": limit,
        "offset": offset,
      };
      _uri = Uri.parse(LIST_ALL_LEMBAGA_AMAL);
    } else {
      params = {
        "idUser": idUser,
        "limit": limit,
        "offset": offset,
        "category": category
      };
      _uri = Uri.parse(LIST_ALL_LEMBAGA_AMAL_BY_CATEGORY);
    }

    final uriParams = _uri.replace(queryParameters: params);
    final response = await client.get(uriParams);
    print('--> response_lembaga_amal ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(lembagaAmalModelFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('--> _no_content_');
    }
  }

  Future<List<LembagaAmalModel>> fetchLembagaAmalbyFollowed(
      String idUser) async {
    Uri _uri = Uri.parse(LIST_ALL_LEMBAGA_AMAL_BY_FOLLOWED);

    var params = {
      "idUser": idUser,
    };

    final uriParams = _uri.replace(queryParameters: params);
    final response = await client.get(uriParams);
    print('--> response_lembaga_amal_by_category ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(lembagaAmalModelFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('--> _no_content_');
    }
  }

  Future followLembagaAmal(String idUser, String idAccountAmil) async {
    Map params = {
      "idFollower": idUser,
      "idFollowed": idAccountAmil,
    };

    final response = await client.post(FOLLOW_LEMBAGA_AMAL_URL,
        headers: headers, body: json.encode(params));

    print('--> _response_followed ${response.statusCode}');
    print('${response.body}');
    if (response.statusCode == 201) {
      print('Ok Followed');
      return response;
    }
  }

  Future unfollowLembagaAmal(String idUser, String idAccountAmil) async {
    Uri uri = Uri.parse(UNFOLLOW_LEMBAGA_AMAL_URL);

    var params = {
      "idFollower": idUser,
      "idFollowed": idAccountAmil,
    };

    final uriParams = uri.replace(queryParameters: params);
    final response = await client.post(uriParams);

    print('--> _response_unfollow_ ${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      return response;
    }
  }

  Future<http.Response> getListLembagaAmalByFollowed() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var userId = _pref.getString(USER_ID_KEY);
    var params = {
      "idUser": userId,
    };
    Uri _uri = Uri.parse(LIST_ALL_LEMBAGA_AMAL_BY_FOLLOWED);
    final uriParams = _uri.replace(queryParameters: params);
    return await client.get(uriParams);
  }

  Future<http.Response> getLembagaAmalByEmail(String email) async {
    var params = {
      "email": email,
    };
    Uri _uri = Uri.parse(LEMBAGA_AMAL_BY_EMAIL);
    final uriParams = _uri.replace(queryParameters: params);
    return await client.get(uriParams);
  }
}
