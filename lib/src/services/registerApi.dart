import 'dart:io';

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/RegisterResponse.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter_jaring_ummat/src/models/postModel.dart';

class RegisterApiProvider {
  Dio dio = new Dio();
  Client client = new Client();

  Map<String, String> headers = {
    'Content-type': 'application/json',
  };

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

    Map paramsLembaga = {
      "namaLembaga": data.fullname,
      "emailLembaga": data.email,
      "categoryLembaga": "-",
      "contactLembaga": "-",
      "alamatLembaga": "-"
    };

    final response = await client.post(REGISTRATION_URL,
        headers: headers, body: json.encode(params));
    if (response.statusCode == 201) {
      await client.post(CREATE_LEMBAGA_AMAL,
          headers: headers, body: json.encode(paramsLembaga));
      return compute(registerResponseModelFromJson, response.body);
    } else if (response.statusCode == 500) {
      Flushbar(
        margin: EdgeInsets.all(8.0),
        borderRadius: 8.0,
        message: "Akun anda sudah terdaftar sebelumnya",
        leftBarIndicatorColor: Colors.redAccent,
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }

  Future saveContent(contentId, contentFile, types, content) async {
    FormData formData = new FormData.from({
      "contentId": contentId,
      "contentFile": contentFile,
      "types": types,
      "content": new UploadFileInfo(new File("./$content"), content),
    });

    final response = await dio.post(UPLOADER_MEDIA_IMAGE, data: formData);
    if (response.statusCode == 200) {
      return response;
    } else {
      print('--> Failed to save image user');
    }
  }
}
