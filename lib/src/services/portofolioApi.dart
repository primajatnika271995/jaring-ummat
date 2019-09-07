import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/sebaranAktifitasAmalModel.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class PortofolioProvider {
  Client client = new Client();

  Future<SebaranAktifitasAmalModel> fetchSebaranAktifitasAmal() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);

    Map<String, String> headers = {
      'Authorization': 'Bearer $token'
    };

    final response = await client.get(PORTOFOLIO_PIE_CHART, headers: headers);
    print('--> Response Status Code PIE : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(sebaranAktifitasAmalModelFromJson, response.body);
    } else {
      print('Err : ${response.statusCode}');
    }
  }

  Future fetchAktifitasTerbesar() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }

  Future fetchAktifitasTerbaru() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }
}
