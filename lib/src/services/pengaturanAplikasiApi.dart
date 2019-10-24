import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/pengaturanAplikasiModel.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class PengaturanAplikasiProvider {
  Client _client = new Client();
  
  Future<PengaturanAplikasiModel> pengaturanAplikasi() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var idUser = _pref.getString(USER_ID_KEY);
    
    final response = await _client.get(PENGATURAN_APLIKASI_URL + '/$idUser');
    print('Response Pengaturan Aplikasi');

    if (response.statusCode == 200) {
      return compute(pengaturanAplikasiModelFromJson, response.body);
    } return null;
  }

}