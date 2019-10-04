import 'dart:io';

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/FilePathResponse.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/RegisterResponse.dart';
import 'package:flutter_jaring_ummat/src/models/muzakkiUserDetails.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterApiProvider {
  Dio dio = new Dio();
  Client client = new Client();
  var params;
  Uri _uri;

  final String contentFile = "Users Profile";
  final String types = "image";

  Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  Future<MuzakkiUserDetails> updateUser(MuzakkiUserDetails value) async {
    //  Sharedpreferences
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);
    var idUser = _pref.getString(USER_ID_KEY);

    Map<String, String> header = {
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json',
    };

    Map body = {
      "alamat": value.alamat,
      "contact": value.contact,
      "email": value.email,
      "fullname": value.fullname,
      "kotaLahir": value.kotaLahir,
      "kotaTinggal": "Jakarta",
      "latitudeLahir": null,
      "latitudeTinggal": value.latitudeTinggal,
      "lokasiAmal": null,
      "longitudeLahir": null,
      "longitudeTinggal": value.longitudeTinggal,
      "tanggalLahir": value.tanggalLahir,
      "kabupaten": value.kabupaten,
      "provinsi": value.provinsi,
      "userId": idUser,
      "kabupatenLahir": value.kabupatenLahir,
      "provinsiLahir": value.provinsiLahir
    };

    final response = await client.post(UPDATE_USER_DETAILS,
        headers: header, body: json.encode(body));
    print('Update User Response : ${response.statusCode}');
    if (response.statusCode == 201) {
      return compute(muzakkiUserDetailsFromJson, response.body);
    }
    return null;
  }

  Future<MuzakkiUserDetails> updateLokasiAmal(String lokasiAmal) async {
    //  Sharedpreferences
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);
    var idUser = _pref.getString(USER_ID_KEY);

    // Check if Token null

    if (token == null) {
      token =
          "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NzI4MTY0NDcsInVzZXJfbmFtZSI6InByaW1hamF0bmlrYTI3MTk5NUBnbWFpbC5jb20iLCJhdXRob3JpdGllcyI6WyJST0xFX1NZU1RFTUFETUlOIl0sImp0aSI6IjU4ODE4Y2NjLWE0MDItNDZmMi05MzAxLTU0YWYyZWI2OTQ5MCIsImNsaWVudF9pZCI6ImphcmluZ3VtYXQiLCJzY29wZSI6WyJyZWFkIiwid3JpdGUiXX0.RHDFSwbEnJQQQiwn52TEelzmE0zvZNSdXPLkmgOd52RB7pL6MDe-OyCC-S0maKs1Exr-5YRiHHbYINnlKAViEX6W2n34THLD9DsAFgDZjHAAsCB4uwVGS2cg79dNUvb_W13oXmusEFYMuBAOCuZ5724OhmSOl2PBN_OmODjLRqsPwEP6GMfadgP0-mwc8I9_yUh8O-JEMBCsXRR0cNEdkkS6Fuq3UI1k0UIQHn2D8HXy6Tmyz9v4bwFlQH0orHB6O1oVKkcAu0ixBu-TbzQ5vVhmmdxzYrHdToxGQ2Rienk57DCrN6KOazbvWoIxlZLmq-MVVGxqN7xe1gLxOTgFbA";
    }

    Map<String, String> header = {'Authorization': 'Bearer $token'};

    params = {"idUser": idUser, "lokasiAmal": lokasiAmal};
    _uri = Uri.parse(UPDATE_LOKASI_AMAL);

    final uriParams = _uri.replace(queryParameters: params);
    final response = await client.post(uriParams, headers: header);

    print('_response_code : ${response.statusCode}');
    if (response.statusCode == 201) {
      return compute(muzakkiUserDetailsFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('--> No Content');
    } else {
      print('--> Err : ${response.statusCode}');
    }
    return null;
  }

  Future<RegisterResponseModel> saveUser(
      BuildContext context, PostRegistration data) async {
    Map params = {
      "tipe_user": data.tipe_user,
      "password": data.password,
      "username": data.email,
      "email": data.email,
      "fullname": data.fullname,
      "contact": data.contact
    };

    final response = await client.post(REGISTRATION_URL,
        headers: headers, body: json.encode(params));

    if (response.statusCode == 201) {
      RegisterResponseModel value =
          registerResponseModelFromJson(response.body);
      return value;
    }
    return null;
  }

  Future<FilePathResponseModel> saveFilepath(
      BuildContext context, FilePathResponseModel data, String idUser) async {
    Map params = {
      "idUser": idUser,
      "resourceType": data.resourceType,
      "urlType": data.urlType,
      "url": data.url,
    };

    final response = await client.post(FILE_PATH_SAVE,
        headers: headers, body: json.encode(params));

    if (response.statusCode == 201) {
      FilePathResponseModel value =
          filePathResponseModelFromJson(response.body);
      return value;
    }
    return null;
  }
}
