
import 'package:dio/dio.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';

class UserDetailsService {
  Response response;
  Dio dio = new Dio();
  Future<Response> userDetails(String email) async {
    return await dio.get(USER_DETAILS_URL, queryParameters: {
      "email": email
    });
  }
}