import 'dart:io';

import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:flutter_jaring_ummat/src/services/cloudinaryApi.dart';

class CloudinaryClient extends CloudinariApi {
  String _cloudName;
  String _apiKey;
  String _apiSecret;

  CloudinaryClient(String apiKey, String apiSecret, String cloudName) {
    this._cloudName = cloudName;
    this._apiKey = apiKey;
    this._apiSecret = apiSecret;
  }

  Future<Response> uploadImage(String imagePath, {String filename, String folder}) async {
    print('Upload Image');

    int timeStamp = new DateTime.now().millisecondsSinceEpoch;

    if (imagePath == null) {
      throw Exception("imagePath must not be null");
    }

    String publicId = imagePath.split('/').last;
    publicId = publicId.split('.')[0];

    if (filename != null) {
      publicId = filename.split('.')[0] + "_" + timeStamp.toString();
    }

    FormData formData = new FormData.from({
      "api_key": _apiKey,
      "folder": folder,
      "public_id": publicId,
      "file": new UploadFileInfo(new File(imagePath), filename),
      "timestamp": timeStamp,
      "signature": getSignature(folder, publicId, timeStamp)
    });

    Dio dio = await getApiClient();
    Response response = await dio.post(_cloudName + "/image/upload", data: formData);
    return response;
  }

  Future<Response> uploadVideo(String videoPath, {String filename, String folder}) async {
    print('Upload Video');

       int timeStamp = new DateTime.now().millisecondsSinceEpoch;

    if (videoPath == null) {
      throw Exception("imagePath must not be null");
    }

    String publicId = videoPath.split('/').last;
    publicId = publicId.split('.')[0];

    if (filename != null) {
      publicId = filename.split('.')[0] + "_" + timeStamp.toString();
    }

    FormData formData = new FormData.from({
      "api_key": _apiKey,
      "folder": folder,
      "public_id": publicId,
      "file": new UploadFileInfo(new File(videoPath), filename),
      "timestamp": timeStamp,
      "signature": getSignature(folder, publicId, timeStamp)
    });

    Dio dio = await getApiClient();
    Response response = await dio.post(_cloudName + "/video/upload", data: formData);
    print(response.statusCode);
    return response;
  }

  String getSignature(String folder, String publicId, int timeStamp) {
    var buffer = new StringBuffer();
    if (folder != null) {
      buffer.write("folder=" + folder + "&");
    }
    if (publicId != null) {
      buffer.write("public_id=" + publicId + "&");
    }

    buffer.write("timestamp=" + timeStamp.toString() + _apiSecret);
    var bytes = utf8.encode(buffer.toString().trim());
    print(sha1.convert(bytes).toString());
    return sha1.convert(bytes).toString();
  }
}
