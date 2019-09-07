import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/historiTransaksiModel.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class HistoriTransaksiProvider {
  Client client = new Client();

  Future<List<HistoriTransaksiModel>> historiTransaksi() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);

    Map<String, String> header = {'Authorization': 'Bearer $token'};

    final response = await client.get(HISTORY_TRANSACTION, headers: header);
    print('--> Response Status Code Histori Transaksi : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(historiTransaksiModelFromJson, response.body);
    } else {
      print('Err : ${response.statusCode}');
    }
  }
}
