import 'dart:io';

import 'package:http/http.dart' show Client;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

import '../config/urls.dart';
import '../models/RegistrationModel.dart';

class RegisterApiProvider {
  Client client = Client();

  Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  Future saveUser(username, fullname, email, tipe_user, password, contact) async {
    Map params = {
      "username": username,
      "fullname": fullname,
      "email": email,
      "tipe_user": tipe_user,
      "password": password,
      "contact": contact
    };

    final response = await client.post(REGISTRATION_URL, headers: headers, body: json.encode(params));
    if (response.statusCode == 201) {
      return compute(registationFromJson, response.body);
    } else {
      Exception("Failed to Save User");
    }
  }

  Future saveContent(contentId, contentFile, types, contentImage) async {

    FormData formData = new FormData.from(
      {
        "contentId": contentId,
        "contentFile": contentFile,
        "types": types,
        "contentImage": new UploadFileInfo(new File("./${contentImage}"), contentImage),
      }
    );
    
    final response = await client.post(UPLOADER_MEDIA_IMAGE, body: formData);
    if (response.statusCode == 200) {
      return response;
    } else {
      Exception("Failed to Save Content");
    }
  }
}