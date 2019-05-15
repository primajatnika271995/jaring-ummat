import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import 'package:flutter_jaring_ummat/src/config/urls.dart';

class RegisterService {

    Response response;

    Future<Response> register(String username, String password, String email, String contact, String profile_picture) async {

      FormData formData =  new FormData.from(
        {
          "username": username,
          "fullname": username,
          "tipe_user": "MUZAKKI",
          "email": email,
          "password": password,
          "contact": contact,
          "profile_picture": new UploadFileInfo(new File("./${profile_picture}"), profile_picture),
        }
      );

      return await Dio().post(REGISTRATION_URL, data: formData);
    }

    Future<Response> checkoutEmail(String email) async {

      return await Dio().get(CHECK_REGISTRATION_EMAIL, queryParameters: {
        "email": email
      });
    }

//   Future<http.Response> register(String username, String password, String email) async {
//     Map<String, String> headers = {
//       'Content-type': 'application/json',
// //      'Accept': 'application/json',
//     };

//     Map params = {
//       "username": username,
//       "password": password,
//       "email": email
//     };

//     return await http.post(REGISTRATION_URL, headers: headers, body: json.encode(params));
//   }


}