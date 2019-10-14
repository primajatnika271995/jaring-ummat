import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/barChartModel.dart';
import 'package:flutter_jaring_ummat/src/models/lineChartModel.dart';
import 'package:flutter_jaring_ummat/src/models/penerimaanAmalTerbesarModel.dart';
import 'package:flutter_jaring_ummat/src/models/sebaranAktifitasAmalModel.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PortofolioPenerimaanProvider {
  Client client = new Client();

  Future<http.Response> pieChartLembagaDetailsApi(String idLembaga) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);

    Uri uri = Uri.parse(PORTOFOLIO_PIE_CHART);
    var params = {"lembagaAmalId": idLembaga};
    final uriParams = uri.replace(queryParameters: params);

    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    return client.get(uriParams, headers: headers);
  }

  Future<List<BarchartModel>> barChartLembagaDetailsApi(String idLembaga, String category, String type) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);

    Uri uri = Uri.parse(BAR_CHART_AMIL);
    var params = {"lembagaId": idLembaga, "category": category, "type": type};
    final uriParams = uri.replace(queryParameters: params);

    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await client.get(uriParams, headers: headers);

    print(response.statusCode);

    if (response.statusCode == 200) {
      return compute(barchartModelFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('No Content');
    } return null;
  }

  Future<List<LineChartModel>> lineChartLembagaDetailsApi(String idLembaga, String category) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);

    Uri uri = Uri.parse(PORTOFOLIO_LINE_CHART);
    var params = {"lembagaAmalId": idLembaga, "categoryName": category};
    final uriParams = uri.replace(queryParameters: params);

    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await client.get(uriParams, headers: headers);

    // print(response.statusCode);

    if (response.statusCode == 200) {
      return compute(lineChartModelFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('No Content');
    } return null;
  }

  Future<List<PenerimaanAmalTerbesarModel>> fetchPenerimaAmalTerbesarLembagaDetails(String idLembaga) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);

    Uri uri = Uri.parse(PENERIMA_AMAL_TERBESAR);
    var params = {"lembagaAmalId": idLembaga};
    final uriParams = uri.replace(queryParameters: params);
    print(uriParams);

    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    final response = await client.get(uriParams, headers: headers);
    print('Penrima amal terbesar response : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(penerimaanAmalTerbesarModelFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('No Content');
    }
    return null;
  }

  Future<List<PenerimaanAmalTerbesarModel>> fetchPenerimaAmalTerbaruLembagaDetails(String idLembaga) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);

    Uri uri = Uri.parse(PENERIMA_AMAL_TERBARU);
    var params = {"lembagaAmalId": idLembaga, "category": "all"};
    final uriParams = uri.replace(queryParameters: params);
    print(uriParams);

    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    final response = await client.get(uriParams, headers: headers);
    print('Penrima amal terbaru response : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(penerimaanAmalTerbesarModelFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('No Content');
    }
    return null;
  }

  Future<SebaranAktifitasAmalModel> fetchSebaranAktifitasAmalLembagaDetails(String idLembaga) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);

    print("idLembaga : $idLembaga");

    Uri uri = Uri.parse(PORTOFOLIO_PIE_CHART);

    var params = {"lembagaAmalId": idLembaga};

    final uriParams = uri.replace(queryParameters: params);

    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    final response = await client.get(uriParams, headers: headers);
    print('--> Response Status Code PIE : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(sebaranAktifitasAmalModelFromJson, response.body);
    } else {
      print('Err : ${response.statusCode}');
    }
    return null;
  }

  Future<http.Response> pieChartApi() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);
    var idLembaga = _pref.getString(LEMABAGA_AMAL_ID);

    Uri uri = Uri.parse(PORTOFOLIO_PIE_CHART);
    var params = {"lembagaAmalId": idLembaga};
    final uriParams = uri.replace(queryParameters: params);

    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    return client.get(uriParams, headers: headers);
  }

  Future<List<LineChartModel>> lineChartApi(String category) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);
    var idLembaga = _pref.getString(LEMABAGA_AMAL_ID);

    Uri uri = Uri.parse(PORTOFOLIO_LINE_CHART);
    var params = {"lembagaAmalId": idLembaga, "categoryName": category};
    final uriParams = uri.replace(queryParameters: params);

    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await client.get(uriParams, headers: headers);

    // print(response.statusCode);

    if (response.statusCode == 200) {
      return compute(lineChartModelFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('No Content');
    } return null;
  }

  Future<List<BarchartModel>> barChartApi(String category, String type) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);
    var idLembaga = _pref.getString(LEMABAGA_AMAL_ID);

    Uri uri = Uri.parse(BAR_CHART_AMIL);
    var params = {"lembagaId": idLembaga, "category": category, "type": type};
    final uriParams = uri.replace(queryParameters: params);

    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await client.get(uriParams, headers: headers);

    print(response.statusCode);

    if (response.statusCode == 200) {
      return compute(barchartModelFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('No Content');
    } return null;
  }

  Future<SebaranAktifitasAmalModel> fetchSebaranAktifitasAmal() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);
    var idLembaga = _pref.getString(LEMABAGA_AMAL_ID);

    print("idLembaga : $idLembaga");

    Uri uri = Uri.parse(PORTOFOLIO_PIE_CHART);

    var params = {"lembagaAmalId": idLembaga};

    final uriParams = uri.replace(queryParameters: params);

    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    final response = await client.get(uriParams, headers: headers);
    print('--> Response Status Code PIE : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(sebaranAktifitasAmalModelFromJson, response.body);
    } else {
      print('Err : ${response.statusCode}');
    }
    return null;
  }

  Future<List<PenerimaanAmalTerbesarModel>> fetchPenerimaAmalTerbesar() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);
    var idLembaga = _pref.getString(LEMABAGA_AMAL_ID);

    Uri uri = Uri.parse(PENERIMA_AMAL_TERBESAR);
    var params = {"lembagaAmalId": idLembaga};
    final uriParams = uri.replace(queryParameters: params);
    print(uriParams);

    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    final response = await client.get(uriParams, headers: headers);
    print('Penrima amal terbesar response : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(penerimaanAmalTerbesarModelFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('No Content');
    }
    return null;
  }

  Future<List<PenerimaanAmalTerbesarModel>> fetchPenerimaAmalTerbaru() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);
    var idLembaga = _pref.getString(LEMABAGA_AMAL_ID);

    Uri uri = Uri.parse(PENERIMA_AMAL_TERBARU);
    var params = {"lembagaAmalId": idLembaga, "category": "all"};
    final uriParams = uri.replace(queryParameters: params);
    print(uriParams);

    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    final response = await client.get(uriParams, headers: headers);
    print('Penrima amal terbaru response : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(penerimaanAmalTerbesarModelFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('No Content');
    }
    return null;
  }
}
