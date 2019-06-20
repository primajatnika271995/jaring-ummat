import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';

import '../config/urls.dart';

class RegisterApiProvider {
  Dio dio = new Dio();

  Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  Future<http.Response> saveUser(username, fullname, email, tipe_user, password, contact) async {
    Map params = {
      "username": username,
      "fullname": fullname,
      "email": email,
      "tipe_user": tipe_user,
      "password": password,
      "contact": contact
    };

    final response = await http.post(REGISTRATION_URL, headers: headers, body: json.encode(params));
    if (response.statusCode == 201) {
      return response;
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
    
    final response = await dio.post(UPLOADER_MEDIA_IMAGE, data: formData);
    if (response.statusCode == 200) {
      return response;
    } else {
      Exception("Failed to Save Content");
    }
  }
}