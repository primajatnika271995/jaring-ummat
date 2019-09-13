import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/historiTransaksiModel.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class HistoriTransaksiProvider {
  Client client = new Client();

  Future<List<HistoriTransaksiModel>> historiTransaksi(String type) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);

    Uri uri = Uri.parse(HISTORY_TRANSACTION);
    var params = {"type": type};
    final uriParams = uri.replace(queryParameters: params);
    print(uriParams);

    Map<String, String> header = {'Authorization': 'Bearer $token'};

    final response = await client.get(uriParams, headers: header);
    print(
        '--> Response Status Code Histori Transaksi : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(historiTransaksiModelFromJson, response.body);
    } else {
      print('Err : ${response.statusCode}');
    }
  }
}
