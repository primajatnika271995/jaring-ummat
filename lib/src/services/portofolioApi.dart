import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/aktivitasTerbaruModel.dart';
import 'package:flutter_jaring_ummat/src/models/aktivitasTerbesarModel.dart';
import 'package:flutter_jaring_ummat/src/models/sebaranAktifitasAmalModel.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PortofolioProvider {
  Client client = new Client();

  Future<http.Response> pieChartApi() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);

    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    return client.get(PORTOFOLIO_PIE_CHART, headers: headers);
  }

  Future<SebaranAktifitasAmalModel> fetchSebaranAktifitasAmal() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);

    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    final response = await client.get(PORTOFOLIO_PIE_CHART, headers: headers);
    print('--> Response Status Code PIE : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(sebaranAktifitasAmalModelFromJson, response.body);
    } else {
      print('Err : ${response.statusCode}');
    }
    return null;
  }

  Future<List<AktivitasAmalTerbaruModel>> fetchAktivitasTerbesar() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);
    var username = _pref.getString(EMAIL_KEY);

    Uri uri = Uri.parse(AKTIVITAS_TERBESAR_URL);
    var params = {"username": username};
    final uriParams = uri.replace(queryParameters: params);
    print(uriParams);

    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    final response = await client.get(uriParams, headers: headers);
    print('Penrima amal terbesar response : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(aktivitasAmalTerbaruModelFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('No Content');
    }
    return null;
  }

  Future<List<AktivitasTerbesarModel>> fetchAktifitasTerbaru() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);

    Uri uri = Uri.parse(AKTIVITAS_TERBARU_URL);
    var params = {"category": "all"};
    final uriParams = uri.replace(queryParameters: params);

    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    final response = await client.get(uriParams, headers: headers);
    print('Aktivitas terbaru response : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(aktivitasTerbesarModelFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('No Content');
    } return null;
  }
}
