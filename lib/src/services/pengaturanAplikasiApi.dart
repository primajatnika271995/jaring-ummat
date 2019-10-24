import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/pengaturanAplikasiModel.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
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

  Future<http.Response> update(PengaturanAplikasiModel value) async {
    Map<String, String> headers = {'Content-type': 'application/json'};

    Map params = {
      "id": value.id,
      "userId": value.userId,
      "aktivitasAmal": value.aktivitasAmal,
      "komentarGalangAmal": value.komentarGalangAmal,
      "pengingatSholat": value.pengingatSholat,
      "ayatAlquranHarian": value.ayatAlquranHarian,
      "aksiGalangAmal": value.aksiGalangAmal,
      "beritaAmil": value.beritaAmil,
      "akunAmilBaru": value.akunAmilBaru,
      "chatDariAmil": value.chatDariAmil,
      "portofolio": value.portofolio,
      "createdDate": value.createdDate,
      "modifyDate": value.modifyDate,
    };

    final response = await _client.post(PENGATURAN_APLIKASI_UPDATE_URL, body: json.encode(params), headers: headers);

    print('Response Update Pengaturan');
    if (response.statusCode == 201) {
      return response;
    } return null;
  }

  Future<http.Response> pnegingatSholatGetKota(String kota) async {
    final response = await _client.get(PENGINGAT_SHOLAT_GET_LOKASI + '/$kota');

    print('Response PengingatSholat Get Kota ${response.statusCode}');
    if (response.statusCode == 200) {
      return response;
    } return null;
  }

  Future<http.Response> jadwalSholat(String idKota, String tanggal) async {
    final response = await _client.get(JADWAL_SHOLAT_URL + '/$idKota/tanggal/$tanggal');

    print('Response Jadwal Sholat ${response.statusCode}');
    if (response.statusCode == 200) {
      return response;
    } return null;
  }

}