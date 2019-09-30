import 'package:dio/dio.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';

class CloudinariApi {
  final Dio dio = Dio();

  String baseUrl = CLOUDINARY_URL;

  CloudinariApi();

  Future<Dio> getApiClient({InterceptorsWrapper interceptor}) async {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.clear();
    if (interceptor != null) {
      dio.interceptors.add(interceptor);
    }
    return dio;
  }

  Future<Response<T>> httpGet<T>(String url, {Map<String, dynamic> params}) async {
    Dio dio = await getApiClient();
    if (params != null)
      return await dio.get(url, queryParameters: params);
    else
      return await dio.get(url);
  }

  Future<Response<T>> httpPost<T>(String url, Map<String, dynamic> params) async {
    Dio dio = await getApiClient();
    if (params != null)
      return await dio.post(url, data: params);
    else
      return await dio.post(url);
  }
}
