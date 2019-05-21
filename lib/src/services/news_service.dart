import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';

import '../config/urls.dart';

class NewsService {

    Dio dio = new Dio();

    Future<Response> getNewsListThumbnail() async {
      return await dio.get(NEWS_GET_LIST_THUMBNAIL);
    }

    Future<Response> getNewsListOrigin() async {
      return await dio.get(NEWS_GET_LIST_ORIGINAL);
    }

    Future<Response> saveNews(String title, String user_id, String kategori, String description, String createdBy, String berita1, String berita2, String img_profile) async {

      FormData formData =  new FormData.from(
          {
            "idUser": user_id,
            "title": title,
            "createdBy": createdBy,
            "category": kategori,
            "description": description,
            "img_profile" : new UploadFileInfo(new File("./${berita1}"), berita1),
            "img_berita1": new UploadFileInfo(new File("./${berita1}"), berita1),
            "img_berita2": new UploadFileInfo(new File("./${berita2}"), berita2)
          }
      );

      return await dio.post(NEWS_CREATE, data: formData);
    }
}